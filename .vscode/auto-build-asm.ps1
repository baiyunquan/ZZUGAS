param(
    [Parameter(Mandatory = $true)]
    [string]$Source,

    [Parameter(Mandatory = $false)]
    [ValidateSet('Debug', 'Release', 'DebugX86')]
    [string]$Mode = 'Debug',

    [Parameter(Mandatory = $false)]
    [string]$Output
)

$ErrorActionPreference = 'Stop'

$fallbackGccDir = 'C:\workspace\soft\msys2\mingw64\bin'
if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
    if (Test-Path -LiteralPath $fallbackGccDir) {
        $env:PATH = "$fallbackGccDir;$env:PATH"
    }
}

if (-not (Test-Path -LiteralPath $Source)) {
    Write-Error "Source file not found: $Source"
    exit 1
}

if ([string]::IsNullOrWhiteSpace($Output)) {
    $srcDir = Split-Path -Path $Source -Parent
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($Source)

    switch ($Mode) {
        'Release' { $Output = Join-Path $srcDir ($baseName + '_release.exe') }
        'DebugX86' { $Output = Join-Path $srcDir ($baseName + '_x86.exe') }
        default { $Output = Join-Path $srcDir ($baseName + '.exe') }
    }
}

if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
    Write-Error 'gcc not found in PATH'
    exit 1
}

$tmpRoot = Join-Path $env:TEMP 'vscode-asm-auto-build'
New-Item -ItemType Directory -Path $tmpRoot -Force | Out-Null

$buildRoot = Join-Path $tmpRoot ([guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $buildRoot -Force | Out-Null

$fileName = [System.IO.Path]::GetFileName($Source)
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($Source)

$srcTmp = Join-Path $buildRoot $fileName
$objTmp = Join-Path $buildRoot ($baseName + '.o')
$exeTmp = Join-Path $buildRoot ($baseName + '.exe')

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

$workspaceRoot = Split-Path -Path $PSScriptRoot -Parent
$ioLib = Join-Path $workspaceRoot 'ZZUGAS\lib\io_windows64.a'

$sourceText = Get-Content -LiteralPath $Source -Raw
$needsIo = $false
if ($Mode -ne 'DebugX86') {
    $needsIo = $sourceText -match '\b(dispmsg|dispcrlf|dispc|disphb|disphw|disphd|disphx|dispuid|dispsid|readmsg|readc|readhd|readuid|readsid)\b'
}

if ($needsIo -and (Test-Path -LiteralPath $ioLib)) {
    & gcc @linkFlags $objTmp $ioLib -o $exeTmp
} else {
    & gcc @linkFlags $objTmp -o $exeTmp
}

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$outDir = Split-Path -Path $Output -Parent
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

Copy-Item -LiteralPath $exeTmp -Destination $Output -Force
Write-Host "Built: $Output"

Write-Host "Auto built: $Output"
