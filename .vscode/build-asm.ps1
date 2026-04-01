param(
    [Parameter(Mandatory = $true)]
    [string]$Source,

    [Parameter(Mandatory = $true)]
    [string]$Output,

    [Parameter(Mandatory = $true)]
    [ValidateSet('Debug', 'Release', 'DebugX86')]
    [string]$Mode
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Source)) {
    Write-Error "Source file not found: $Source"
    exit 1
}

$tmpRoot = Join-Path $env:TEMP 'vscode-asm-build'
New-Item -ItemType Directory -Path $tmpRoot -Force | Out-Null

$fileName = [System.IO.Path]::GetFileName($Source)
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($Source)

$srcTmp = Join-Path $tmpRoot $fileName
$objTmp = Join-Path $tmpRoot ($baseName + '.o')
$exeTmp = Join-Path $tmpRoot ($baseName + '.exe')

Copy-Item -LiteralPath $Source -Destination $srcTmp -Force

$asmFlags = @()
$linkFlags = @('-no-pie')

switch ($Mode) {
    'Debug' {
        $asmFlags += '-g'
    }
    'Release' {
        $asmFlags += '-O2'
        $linkFlags += '-s'
    }
    'DebugX86' {
        $asmFlags += @('-g', '-m32')
        $linkFlags += '-m32'
    }
}

& gcc @asmFlags -c $srcTmp -o $objTmp
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

& gcc @linkFlags $objTmp -o $exeTmp
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$outDir = Split-Path -Path $Output -Parent
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

Copy-Item -LiteralPath $exeTmp -Destination $Output -Force
Write-Host "Built: $Output"
