@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0KR-Windows.ps1" -Source "src\hello.cpp" -Std c++23 -Run
if errorlevel 1 pause
endlocal
