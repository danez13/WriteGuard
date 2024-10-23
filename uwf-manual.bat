@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

setlocal enabledelayedexpansion enabledelayedexpansion

set "searchString=Enabled"

echo determining if Device Lockdown feature is enabled...
for /f "delims=" %%i in ('Dism /online /Get-Features /format:table ^| find "Client-DeviceLockdown"') do (
    set "output=!output! %%i"
)
echo !output! > temp.txt

findstr /C:"%searchString%" temp.txt > nul

if errorlevel 1 (
    echo enabling Device Lockdown feature...
    DISM /Online /Enable-Feature /FeatureName:Client-DeviceLockdown
) else (
    echo Device Lockdown is enabled
)

echo determining if Unified Write Filter feature is enabled...
for /f "delims=" %%i in ('Dism /online /Get-Features /format:table ^| find "Client-UnifiedWriteFilter"') do (
    set "output=!output! %%i"
)
echo !output! > temp.txt

findstr /C:"%searchString%" temp.txt > nul

if errorlevel 1 (
    echo enabling Unified Write Filter feature...
    DISM /Online /Enable-Feature /FeatureName:Client-UnifiedWriteFilter
) else (
    echo Unified Write Filter feature is enabled
)
endlocal

del temp.txt