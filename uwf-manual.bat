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

setlocal enabledelayedexpansion
set "searchString=Enabled"
choice /C EDRX /M "Do you want to Enable UWF, Disable UWF, Reboot the system, or exit?"
if %errorlevel% equ 1 (
    choice /c YN /M "are you sure you want to enable UWF"
    if %errorlevel% equ 2 (
        :: echo determining if Device Lockdown feature is enabled...
        for /f "delims=" %%i in ('Dism /online /Get-Features /format:table ^| find "Client-DeviceLockdown"') do (
            set "output=!output! %%i"
        )
        echo !output! > temp.txt

        findstr /C:"%searchString%" temp.txt > nul

        if %errorlevel% equ 1 (
            echo enabling Device Lockdown feature...
            DISM /Online /Enable-Feature /FeatureName:Client-DeviceLockdown
        ) else (
            echo Device Lockdown is enabled
        )

        @REM echo determining if Unified Write Filter feature is enabled...
        for /f "delims=" %%i in ('Dism /online /Get-Features /format:table ^| find "Client-UnifiedWriteFilter"') do (
            set "output=!output! %%i"
        )
        echo !output! > temp.txt

        findstr /C:"%searchString%" temp.txt > nul

        if %errorlevel% equ 1 (
            echo enabling Unified Write Filter feature...
            DISM /Online /Enable-Feature /FeatureName:Client-UnifiedWriteFilter
        ) else (
            echo Unified Write Filter feature is enabled
        )
    ) else if %errorlevel% equ 3 (
        call uwf-manual.bat
        exit /b
    )
) else if errorlevel 2 (
    echo 2
)
if errorlevel 3 (
    echo 3
)
if errorlevel 4 (
    echo 4
)
del temp.txt
endlocal