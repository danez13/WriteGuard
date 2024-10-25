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

:start
uwfmgr get-config > config.txt
setlocal EnableDelayedExpansion
choice /C FX /M "Do you want to see the filter menu, or exit?"
if %errorlevel% equ 1 (
    cls
    goto :filterMenu
)
if %errorlevel% equ 2 (
    goto :exit
)
endlocal

:filterMenu
choice /C EDRB /M "Do you want to Enable UWF, Disable UWF, or return back to the start menu?"
if %errorlevel% equ 1 (
    findstr /C:"Filter state:     ON" config.txt > nul
    if %errorlevel% equ 1 (
        uwfmgr filter enable
        pause
        cls
        goto :filterMenu
    ) else (
        goto :EnableClient-Features
    )
)
if %errorlevel% equ 2 (
    findstr /C:"Filter state:     OFF" config.txt > nul
    if errorlevel 1 (
        uwfmgr filter disable
        pause
        cls
        goto :start
    )
)
if errorlevel 3 (
    uwfmgr filter Reset-Settings
    pause
    cls
    goto :start
)
if %errorlevel% equ 4 (
    cls
    goto :start
)

:EnableClient-Features
choice /C YN /M "are you sure you want to enable UWF?"
if %errorlevel% equ 1 (
    goto :EnableFeatures 
) else (
    cls
    goto :filterMenu
)

:EnableFeatures
setlocal
Dism /online /Get-Features /format:table | find "Client-DeviceLockdown" > temp.txt
findstr /C:"Enabled" temp.txt > nul
if errorlevel 1 (
    echo enabling Device Lockdown feature...
    DISM /Online /Enable-Feature /FeatureName:Client-DeviceLockdown
) else (
    echo Device Lockdown is enabled
)

Dism /online /Get-Features /format:table | find "Client-UnifiedWriteFilter" > temp.txt

findstr /C:"Enabled" temp.txt > nul

if errorlevel 1 (
    echo enabling Unified Write Filter...
    DISM /Online /Enable-Feature /FeatureName:Client-UnifiedWriteFilter
) else (
    echo Unified Write Filter is enabled
)

findstr /C:"Filter state:     OFF" config.txt > nul

if errorlevel 1 (
    uwfmgr filter enable
)

pause
endlocal
cls
goto :filterMenu

:exit
exit