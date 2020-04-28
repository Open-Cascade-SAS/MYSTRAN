@ECHO OFF
SETLOCAL

set "NASTRANEXE=%~dp0nastran.exe"
set "CURDIR=%CD%"

call:getTMPDIR

set "OUTDIR=%CURDIR%"
set "PROBNAME=%OUTDIR%\%~n1"

for %%A in ("%~1") do set "INPUT=%%~dpfxA"

MKDIR "%TMPDIR%"
CHDIR /D "%TMPDIR%"
"%NASTRANEXE%" "%INPUT%" > "%PROBNAME%.out"
CHDIR /D "%CURDIR%"
RMDIR /Q /S "%TMPDIR%"

ENDLOCAL
goto:eof

:: =====================================================================
:: This function generates temporary directory
:getTMPDIR
set /a "TMPDIR=%RANDOM%+100000"
set "TMPDIR=%TMP%\Tmp%TMPDIR:~-5%.TMP"
if exist %TMPDIR% goto :getTMPDIR
exit /B 0
goto:eof

