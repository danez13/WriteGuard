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
if exist "%WINDIR%\system32\uwfmgr.exe" (
    uwfmgr get-config > config.txt 
) else (
    break > config.txt
)
setlocal EnableDelayedExpansion
choice /C FVEX /M "Do you want to see the filter menu (F), volume menu (V), File Exclusion menu (E), or exit (X)?"
if %errorlevel% equ 1 (
    cls
    goto :filterMenu
)
if %errorlevel% equ 2 (
    cls
    goto :volumeMenu
)
if %errorlevel% equ 3 (
    cls
    goto :fileMenu
)
if %errorlevel% equ 4 (
    goto :exit
)
endlocal

:filterMenu
choice /C EDRB /M "Do you want to Enable UWF (E), Disable UWF (D), Reboot (R), or return back to the start menu (B)?"
if %errorlevel% equ 1 (
    findstr /C:"Filter state:     ON" config.txt > temp.txt
    if errorlevel 1 (
        uwfmgr filter enable
        pause
        cls
        goto :filterMenu
    ) else (
        goto :EnableFeatures
    )
)
if %errorlevel% equ 2 (
    findstr /C:"Filter state:     OFF" config.txt > nul
    if errorlevel 1 (
        uwfmgr filter disable
        pause
        cls
        goto :filterMenu
    )
)
if %errorlevel% equ 3 (
    cls
    shutdown /r /t 5 /c "Reconfiguring UWF.exe" /f /d p:4:1
    goto :exit
)
if %errorlevel% equ 4 (
    cls
    goto :start
)

:volumeMenu
choice /C PUDRB /M "Do you want to protect a volume (P), unprotect a volume (U), view volume details (D), reboot (R), or go back to the start menu (B)?"
if %errorlevel% equ 1 ( 
    goto :protect
)
if %errorlevel% equ 2 ( 
    goto :unprotect
)
if %errorlevel% equ 3 ( 
    if exist "%WINDIR%\system32\uwfmgr.exe" (
        goto :displayvolumes  
    ) else (
        echo "please enable Unified Write Filter"
        pause
        goto :volumeMenu
    ) 
)
if %errorlevel% equ 4 (
    cls
    shutdown /r /t 5 /c "Reconfiguring Volumes.exe" /f /d p:4:1
    goto :exit
)
if %errorlevel% equ 5 (
    cls 
    goto :start 
)

:fileMenu
choice /C GAKRB /M "do you want to Get volume exclusions (G), Add an exclusion (A), remove and exclusion (K),reboot (R), or go back to the start Menu (B)"
if %errorlevel% equ 1 (
    goto :getExclusions
)
if %errorlevel% equ 2 (
    goto :addExclusions
)
if %errorlevel% equ 3 (
    goto :removeExclusions
)
if %errorlevel% equ 4 (
    shutdown /r /t 5 /c "Reconfiguring Exclusions.exe" /f /d p:4:1
)
if %errorlevel% equ 5 (
    cls
    goto :start
)

@REM :EnableClient-Features
@REM choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
@REM if %errorlevel% equ 1 (
@REM     goto :EnableFeatures 
@REM ) else (
@REM     cls
@REM     goto :filterMenu
@REM )

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

:protect
powershell -command "Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name='Size(GB)';Expression={[math]::round($_.Used/1GB,2)}}, @{Name='Free Space(GB)';Expression={[math]::round($_.Free/1GB,2)}}"
set /p drive="Enter the drive letter (e.g., C): "
if exist %drive%:\ (
    uwfmgr volume protect %drive%:
    pause
    cls
    goto :volumeMenu
) else (
    echo The drive %drive%: does not exist.
    pause
    cls
    goto :volumeMenu
)

:unprotect
powershell -command "Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name='Size(GB)';Expression={[math]::round($_.Used/1GB,2)}}, @{Name='Free Space(GB)';Expression={[math]::round($_.Free/1GB,2)}}"
set /p drive="Enter the drive letter (e.g., C): "
if exist %drive%:\ (
    uwfmgr volume Unprotect %drive%:
    pause
    cls
    goto :volumeMenu
) else (
    echo The drive %drive%: does not exist.
    pause
    cls
    goto :volumeMenu
)

:displayvolumes
choice /C 1A /M "do you want to display one (1) or all volumes (A)"
if %errorlevel% equ 1 (
    powershell -command "Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name='Size(GB)';Expression={[math]::round($_.Used/1GB,2)}}, @{Name='Free Space(GB)';Expression={[math]::round($_.Free/1GB,2)}}"
    set /p drive="Enter the drive letter (e.g., C): "
    if exist %drive%:\ (
        uwfmgr volume Get-Config %drive%:
        pause
        cls
        goto :volumeMenu
    )
)
if %errorlevel% equ 2 (
    uwfmgr volume Get-Config all
    pause
    cls
    goto :volumeMenu
)

:getExclusions
powershell -command "Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name='Size(GB)';Expression={[math]::round($_.Used/1GB,2)}}, @{Name='Free Space(GB)';Expression={[math]::round($_.Free/1GB,2)}}"
set /p drive="Enter the drive letter (e.g., C): "
if exist %drive%:\ (
    uwfmgr file get-Exclusions %drive%:
    pause
    cls
    goto :fileMenu
)

:addExclusions
set /p file="enter path to file (e.g., drive:/path/to/file/file.ext OR drive:/path/to/folder/): "
if exist %file% (
    uwfmgr file add-exclusion %file%
    pause
    cls
    goto :fileMenu
) else (
    echo file does not exist
    cls
    goto :fileMenu
)

:removeExclusions
find ":]" config.txt > temp.txt
set /A i = 1
for /f "delims=" %%a in (temp.txt) do (
    if %i% equ 1 (
        set "var=%%a"
        goto :stop
    )
    set %i% += 1
)
:stop
echo %var%
pause

:exit
exit