param(
	[Parameter(Mandatory = $true, Position = 0, HelpMessage = "Input source files (.c/.cc/.cpp/.s/.S)")]
	[string[]]$Sources,

	[Parameter(HelpMessage = "Compiler to use: gcc or clang")]
	[ValidateSet("gcc", "clang")]
	[string]$Compiler = "gcc",

	[Parameter(HelpMessage = "Optimization level: 0,1,2,3,g,s,z,fast,Og (also accepts -O0 style via extra args)")]
	[ValidatePattern("^(0|1|2|3|g|s|z|fast|Og)$")]
	[string]$Optimization = "0",

	[Parameter(HelpMessage = "Output executable file name")]
	[string]$Output = "",

	[Parameter(HelpMessage = "Additional include directories")]
	[string[]]$IncludeDirs = @(),

	[Parameter(HelpMessage = "Additional library directories")]
	[string[]]$LibraryDirs = @(),

	[Parameter(HelpMessage = "Libraries to link (name or file path)")]
	[string[]]$Libraries = @(),

	[Parameter(HelpMessage = "Enable debug symbols (-g)")]
	[switch]$WithDebugSymbols,

	[Parameter(HelpMessage = "Print full compiler command")]
	[switch]$VerboseCmd,

	[Parameter(HelpMessage = "Link ./lib/winio64.a automatically")]
	[switch]$UseWinio64,

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

if ($ExtraArgs) {
	$keptArgs = @()
	foreach ($arg in $ExtraArgs) {
		if ($arg -match "^-O(.+)$") {
			# Support user input like: -O0 or -Og
			$Optimization = $Matches[1]
			continue
		}
		$keptArgs += $arg
	}
	$ExtraArgs = $keptArgs
}

# Normalize optimization values so both Og and g produce -Og.
if ($Optimization -match "^[oO](.+)$") {
	$Optimization = $Matches[1]
}

$validOptimization = @("0", "1", "2", "3", "g", "s", "z", "fast")
if (-not $validOptimization.Contains($Optimization)) {
	throw "Invalid optimization level: $Optimization. Supported values: 0,1,2,3,g,s,z,fast,Og."
}

$allowedExt = @(".c", ".cc", ".cpp", ".s")
$resolvedSources = @()

foreach ($src in $Sources) {
	$fullPath = Resolve-InputPath $src
	$ext = [System.IO.Path]::GetExtension($fullPath).ToLowerInvariant()

	if (-not $allowedExt.Contains($ext)) {
		throw "Unsupported source type: $src (supported: .c/.cc/.cpp/.s/.S)"
	}

	$resolvedSources += $fullPath
}

if ([string]::IsNullOrWhiteSpace($Output)) {
	$baseName = [System.IO.Path]::GetFileNameWithoutExtension($resolvedSources[0])
	$Output = "$baseName.exe"
} elseif (-not $Output.ToLowerInvariant().EndsWith(".exe")) {
	$Output = "$Output.exe"
}

$args = @()
$args += "-O$Optimization"

if ($WithDebugSymbols) {
	$args += "-g"
}

foreach ($inc in $IncludeDirs) {
	$incPath = Resolve-InputPath $inc
	$args += "-I$incPath"
}

foreach ($libDir in $LibraryDirs) {
	$libPath = Resolve-InputPath $libDir
	$args += "-L$libPath"
}

$args += "-o"
$args += $Output
$args += $resolvedSources

if ($UseWinio64) {
	$winioPath = Join-Path $PSScriptRoot "lib/winio64.a"
	if (-not (Test-Path -LiteralPath $winioPath)) {
		throw "Library not found: $winioPath"
	}
	$args += $winioPath
}

foreach ($lib in $Libraries) {
	if (Test-Path -LiteralPath $lib) {
		$args += (Resolve-Path -LiteralPath $lib).Path
	} elseif ($lib -match "^[A-Za-z0-9_+\-]+$") {
		$args += "-l$lib"
	} else {
		$args += $lib
	}
}

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
	throw "Build failed with exit code: $exitCode"
}

Write-Host "Build succeeded: $Output"