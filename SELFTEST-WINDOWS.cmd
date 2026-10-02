@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0KR-Windows.ps1" -SelfTest
if errorlevel 1 pause
endlocal
