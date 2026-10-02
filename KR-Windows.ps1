param(
  [string]$Source = "src\hello.cpp",
  [ValidateSet("c++17","c++20","c++23")][string]$Std = "c++23",
  [switch]$Run,
  [switch]$SelfTest
)
$ErrorActionPreference='Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$ToolRoot = Join-Path $Root 'host\windows-x64\toolchain'
$Clang = Join-Path $ToolRoot 'bin\clang++.exe'
function Require-Toolchain {
  if (!(Test-Path $Clang)) { throw "Bundled offline Windows toolchain is incomplete: $Clang" }
}
function Compile-One([string]$src,[string]$std,[string]$out) {
  Require-Toolchain
  New-Item -ItemType Directory -Path (Split-Path $out) -Force | Out-Null
  & $Clang "-std=$std" -O2 -Wall -Wextra -Wpedantic $src -o $out
  if ($LASTEXITCODE -ne 0) { throw "Compilation failed: $LASTEXITCODE" }
}
Require-Toolchain
if ($SelfTest) {
  $src=Join-Path $Root 'tests\windows-selftest.cpp'; $exe=Join-Path $Root 'output\windows-selftest.exe'
  Compile-One $src 'c++23' $exe
  $text=& $exe
  if ($LASTEXITCODE -ne 0 -or ($text -join "`n") -notmatch 'KR_WINDOWS_OK=42') { throw 'Windows runtime self-test failed.' }
  Write-Host '[PASS] Windows native compile + run: KR_WINDOWS_OK=42' -ForegroundColor Green
  exit 0
}
$srcPath=if([IO.Path]::IsPathRooted($Source)){$Source}else{Join-Path $Root $Source}
if (!(Test-Path $srcPath)) { throw "Source not found: $srcPath" }
$name=[IO.Path]::GetFileNameWithoutExtension($srcPath)
$out=Join-Path $Root "output\$name.exe"
Compile-One $srcPath $Std $out
Write-Host "[PASS] $out" -ForegroundColor Green
if($Run){ & $out; exit $LASTEXITCODE }
