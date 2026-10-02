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
$Archive = Join-Path $Root 'cache\llvm-mingw-20260922-ucrt-x86_64.zip'
$Url = 'https://github.com/mstorsjo/llvm-mingw/releases/download/20260922/llvm-mingw-20260922-ucrt-x86_64.zip'
$Expected = 'e3ad77d117a4bea19a7a3b333341824d79a5a371004a10e25b8504e7b3047666'
function Ensure-Toolchain {
  if (Test-Path $Clang) { return }
  Write-Host '[KR] Windows toolchain is not cached on this USB yet.' -ForegroundColor Yellow
  Write-Host '[KR] One-time download to the USB; nothing is installed in Windows.'
  New-Item -ItemType Directory -Path (Split-Path $Archive) -Force | Out-Null
  if (!(Test-Path $Archive)) { Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $Archive }
  $hash=(Get-FileHash -Algorithm SHA256 $Archive).Hash.ToLowerInvariant()
  if ($hash -ne $Expected) { throw "SHA-256 mismatch: $hash" }
  $tmp=Join-Path $Root 'cache\extract'
  Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
  Expand-Archive -Path $Archive -DestinationPath $tmp -Force
  $dir=Get-ChildItem $tmp -Directory | Select-Object -First 1
  if (!$dir) { throw 'Toolchain archive layout invalid.' }
  Remove-Item $ToolRoot -Recurse -Force -ErrorAction SilentlyContinue
  New-Item -ItemType Directory -Path (Split-Path $ToolRoot) -Force | Out-Null
  Move-Item $dir.FullName $ToolRoot
  Remove-Item $tmp -Recurse -Force
  if (!(Test-Path $Clang)) { throw 'clang++.exe missing after extraction.' }
}
function Compile-One([string]$src,[string]$std,[string]$out) {
  Ensure-Toolchain
  New-Item -ItemType Directory -Path (Split-Path $out) -Force | Out-Null
  & $Clang "-std=$std" -O2 -Wall -Wextra -Wpedantic $src -o $out
  if ($LASTEXITCODE -ne 0) { throw "Compilation failed: $LASTEXITCODE" }
}
Ensure-Toolchain
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
