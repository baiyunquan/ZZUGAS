param(
	[Parameter(Mandatory = $true, Position = 0, HelpMessage = "Input C source files (.c/.cc/.cpp)")]
	[string[]]$Sources,

	[Parameter(HelpMessage = "Compiler to use: gcc or clang")]
	[ValidateSet("gcc", "clang")]
	[string]$Compiler = "gcc",

	[Parameter(HelpMessage = "Optimization level: 0,1,2,3,g,s,z,fast,Og")]
	[ValidatePattern("^(0|1|2|3|g|s|z|fast|Og)$")]
	[string]$Optimization = "Og",

	[Parameter(HelpMessage = "Assembly syntax: intel or att")]
	[ValidateSet("intel", "att")]
	[string]$Syntax = "intel",

	[Parameter(HelpMessage = "Output directory (optional; uses source directory by default)")]
	[string]$OutputDir = "",

	[Parameter(HelpMessage = "Print full compiler command")]
	[switch]$VerboseCmd,

	[Parameter(ValueFromRemainingArguments = $true)]
	[string[]]$ExtraArgs
)

$ErrorActionPreference = "Stop"

function Resolve-InputPath {
	param([string]$PathText)

	if (Test-Path -LiteralPath $PathText) {
		return (Resolve-Path -LiteralPath $PathText).Path
	}

	$localPath = Join-Path $PSScriptRoot $PathText
	if (Test-Path -LiteralPath $localPath) {
		return (Resolve-Path -LiteralPath $localPath).Path
	}

	throw "File not found: $PathText"
}

if (-not (Get-Command $Compiler -ErrorAction SilentlyContinue)) {
	throw "Compiler not found: $Compiler. Please install it and ensure it is in PATH."
}

# Handle -O style arguments in ExtraArgs
if ($ExtraArgs) {
	$keptArgs = @()
	foreach ($arg in $ExtraArgs) {
		if ($arg -match "^-O(.+)$") {
			$Optimization = $Matches[1]
			continue
		}
		$keptArgs += $arg
	}
	$ExtraArgs = $keptArgs
}

# Normalize optimization: convert user Og/O3 style to just the level
if ($Optimization -match "^[oO](.+)$") {
	$Optimization = $Matches[1]
}

$validOptimization = @("0", "1", "2", "3", "g", "s", "z", "fast")
if (-not $validOptimization.Contains($Optimization)) {
	throw "Invalid optimization level: $Optimization. Supported values: 0,1,2,3,g,s,z,fast,Og."
}

# Validate and resolve input files
$allowedExt = @(".c", ".cc", ".cpp")
$resolvedSources = @()

foreach ($src in $Sources) {
	$fullPath = Resolve-InputPath $src
	$ext = [System.IO.Path]::GetExtension($fullPath).ToLowerInvariant()

	if (-not $allowedExt.Contains($ext)) {
		throw "Unsupported source type: $src (supported: .c/.cc/.cpp)"
	}

	$resolvedSources += $fullPath
}

if (-not $OutputDir) {
	Write-Host "No output directory specified; using source directories."
} else {
	if (-not (Test-Path -LiteralPath $OutputDir)) {
		Write-Host "Creating output directory: $OutputDir"
		New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
	}
}

# Set up assembly syntax flag
$syntaxFlag = if ($Syntax -eq "intel") { "-masm=intel" } else { "-masm=att" }

# Generate assembly for each source file
foreach ($src in $resolvedSources) {
	$baseName = [System.IO.Path]::GetFileNameWithoutExtension($src)
	$dirname = [System.IO.Path]::GetDirectoryName($src)
	
	$outDir = if ($OutputDir) { $OutputDir } else { $dirname }
	$outFile = Join-Path $outDir "$baseName.s"

	$args = @()
	$args += "-S"
	$args += "-O$Optimization"
	$args += $syntaxFlag
	$args += "-c"
	$args += "-o"
	$args += $outFile
	$args += $src

	if ($ExtraArgs) {
		$args += $ExtraArgs
	}

	if ($VerboseCmd) {
		$pretty = ($args | ForEach-Object { '"' + $_ + '"' }) -join " "
		Write-Host "Running: $Compiler $pretty"
	}

	& $Compiler @args
	$exitCode = $LASTEXITCODE

	if ($exitCode -ne 0) {
		throw "Assembly generation failed for $src with exit code: $exitCode"
	}

	Write-Host "Generated assembly: $outFile"
}

Write-Host "All assembly files generated successfully."
