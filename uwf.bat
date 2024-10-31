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
choice /C FVEHOX /M "Do you want to see the filter menu (F), volume menu (V), File Exclusion menu (E), Registry Exclusion menu (H), Overlay menu (O), Servicing menu (S), reboot(R), or exit (X)?"
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
    cls
    goto :registryMenu
)
if %errorlevel% equ 5 (
    cls
    goto :overlayMenu
)
if %errorlevel% equ 6 (
    cls
    goto :overlayMenu
)
if %errorlevel% equ 7 (
    choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
    if %errorlevel% equ 1 (
        cls
        shutdown /r /t 5 /c "Reconfiguring UWF.exe" /f /d p:4:1
        goto :exit
    )
    if %errorlevel% equ 2 (
        goto :start
    )
)
if %errorlevel% equ 8 (
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
    choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
    if %errorlevel% equ 1 (
        cls
        shutdown /r /t 5 /c "Reconfiguring UWF.exe" /f /d p:4:1
        goto :exit
    )
    if %errorlevel% equ 2 (
        goto :filterMenu
    )
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
    choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
    if %errorlevel% equ 1 (
        cls
        shutdown /r /t 5 /c "Reconfiguring Volumes" /f /d p:4:1
        goto :exit
    )
    if %errorlevel% equ 2 (
        goto :volumeMenu
    )
)
if %errorlevel% equ 5 (
    cls 
    goto :start 
)

:fileMenu
choice /C GAKCDRB /M "do you want to Get volume exclusions (G), Add an exclusion (A), remove and exclusion (K), commit file (C), delete file (D), reboot (R), or go back to the start Menu (B)"
if %errorlevel% equ 1 (
    goto :getFileExclusions
)
if %errorlevel% equ 2 (
    goto :addFileExclusions
)
if %errorlevel% equ 3 (
    goto :removeExclusions
)
if %errorlevel% equ 4 (
    goto :commitFile
)
if %errorlevel% equ 5 (
    goto :commitDeleteFile
)
if %errorlevel% equ 6 (
    choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
    if %errorlevel% equ 1 (
        cls
        shutdown /r /t 5 /c "Reconfiguring files" /f /d p:4:1
        goto :exit
    )
    if %errorlevel% equ 2 (
        goto :fileMenu
    )
)
if %errorlevel% equ 7 (
    cls
    goto :start
)

:registryMenu
choice /C GAKCDRB /M  "do you want to get registry exclusion (G), add registery exclusion (A), remove registery exclusion (K), commit to registry (C), delete from registry (D), reboot (R), or go back to the start Menu (B)"
if %errorlevel% equ 1 (
    goto :getRegistryExclusions
)
if %errorlevel% equ 2 (
    goto :addRegistryExclusion
)
if %errorlevel% equ 3 (
    goto :removeRegistryExclusion
)
if %errorlevel% equ 4 (
    goto :commitRegistry
)
if %errorlevel% equ 5 (
    goto :commitDeleteRegistry
)
if %errorlevel% equ 6 (
    choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
    if %errorlevel% equ 1 (
        cls
        shutdown /r /t 5 /c "Reconfiguring Registrys" /f /d p:4:1
        goto :exit
    )
    if %errorlevel% equ 2 (
        goto :registryMenu
    )
)
if %errorlevel% equ 7 (
    cls
    goto :start
)

:overlayMenu
choice /C GACSTWLPOIRB /M  "do you want to get overlay config (G), get available space for overlay (A), get overlay consumption (C), set maximum overlay size (S), set storage Type (T), set warning size (W), set critical size (L), turn on/off freespace passthrough (P), turn on/off persistent overlay (O), turn on/off reset persistent overlay (I), reboot(R), go back to start(B)"
if %errorlevel% equ 1 (
    goto :getOverlayConfig
)
if %errorlevel% equ 2 (
    goto :getAvailableSpace
)
if %errorlevel% equ 3 (
    goto :getConsumption
)
if %errorlevel% equ 4 (
    goto :setsize
)
if %errorlevel% equ 5 (
    goto :setType
)
if %errorlevel% equ 6 (
    goto :setWarningThreshold
)
if %errorlevel% equ 7 (
    goto :setCriticalThreshold
)
if %errorlevel% equ 8 (
    goto :setpassthrough
)
if %errorlevel% equ 9 (
    goto :setPersistent
)
if %errorlevel% equ 10 (
    goto :resetPersistent
)
if %errorlevel% equ 11 (
    choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
    if %errorlevel% equ 1 (
        cls
        shutdown /r /t 5 /c "Reconfiguring overlays" /f /d p:4:1
        goto :exit
    )
    if %errorlevel% equ 2 (
        goto :overlayMenu
    )
)
if %errorlevel% equ 12 (
    cls
    goto :start
)

:servicingMenu
choice /C GEDURB /M  "do you want to get servicing config (G), enable servicing (E), disable servicing (D), update windows (U), reboot (R), or go back to start menu (B)"
if %errorlevel% equ 1 (
    goto :getServcingConfig
)
if %errorlevel% equ 2 (
    goto :enableServicing
)
if %errorlevel% equ 3 (
    goto :disableServicing
)
if %errorlevel% equ 4 (
    goto :updateWindows
)
if %errorlevel% equ 5 (
    choice /C YN /M "are you sure you want to enable UWF (Y or N)?"
    if %errorlevel% equ 1 (
        cls
        shutdown /r /t 5 /c "Reconfiguring servicing" /f /d p:4:1
        goto :exit
    )
    if %errorlevel% equ 2 (
        goto :servicingMenu
    )
)
if %errorlevel% equ 6 (
    cls
    goto :start
)
goto :start
pause

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

:getFileExclusions
choice /C 1A /M "do you want to display one (1) or all volumes (A)"
if %errorlevel% equ 1 (
    powershell -command "Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name='Size(GB)';Expression={[math]::round($_.Used/1GB,2)}}, @{Name='Free Space(GB)';Expression={[math]::round($_.Free/1GB,2)}}"
    set /p drive="Enter the drive letter (e.g., C): "
    if exist %drive%:\ (
        uwfmgr file Get-exclusions %drive%:
        pause
        cls
        goto :fileMenu
    )
)
if %errorlevel% equ 2 (
    uwfmgr file Get-exclusions all
    pause
    cls
    goto :fileMenu
)

:addFileExclusions
set /p file="enter path to file (e.g., drive:/path/to/file/file.ext OR drive:/path/to/folder/): "
if exist %file% (
    uwfmgr file add-exclusion %file%
    pause
    cls
    goto :fileMenu
) else (
    echo file does not exist
    pause
    cls
    goto :fileMenu
)

:removeExclusions
uwfmgr file get-exclusions all
set /p file="enter path to file (e.g., drive:/path/to/file/file.ext OR drive:/path/to/folder/): "
if exist %file% (
    uwfmgr file remove-exclusion %file%
    pause
    cls
    goto :fileMenu
) else (
    echo file does not exist
    pause
    cls
    goto :fileMenu
)

:commitFile
set /p file="enter path to file (e.g., drive:/path/to/file/file.ext OR drive:/path/to/folder/): "
if exist %file% (
    uwfmgr file commit %file%
    pause
    cls
    goto :fileMenu
) else (
    echo file does not exist
    pause
    cls
    goto :fileMenu
)

:commitDeleteFile
set /p file="enter path to file (e.g., drive:/path/to/file/file.ext OR drive:/path/to/folder/): "
if exist %file% (
    uwfmgr file commit-delete %file%
    pause
    cls
    goto :fileMenu
) else (
    echo file does not exist
    pause
    cls
    goto :fileMenu
)

:getRegistryExclusions
uwfmgr registry Get-exclusions
pause
cls
goto :registryMenu

:addRegistryExclusion
set /p registryType="enter registry Type (HKCU, HKLM, HKU, HKCC, HKCR): "
reg query %registryType%
set /p registryKey="enter registry key: "
reg query "%registryKey%" >nul 2>&1
if %errorlevel%==0 (
    uwfmgr registry add-exclusion %registryKey%
    pause
    cls
    goto :registryMenu
) else (
    echo The registry key does not exist.
    pause
    cls
    goto :registryMenu
)

:removeRegistryExclusion
uwfmgr registry Get-exclusions
set /p registryKey="enter registry key: "
reg query "%registryKey%" >nul 2>&1
if %errorlevel%==0 (
    uwfmgr registry remove-exclusion %registryKey%
    pause
    cls
    goto :registryMenu
) else (
    echo registry does not exist
    pause
    cls
    goto :registryMenu
)

:commitRegistry
set /p registryType="enter registry Type (HKCU, HKLM, HKU, HKCC, HKCR): "
reg query "%registryType%" >nul 2>&1
if %errorlevel%==0 (
    reg query %registryType%
)
set /p registryKey="enter registry key: "
reg query "%registryKey%" >nul 2>&1
if %errorlevel%==0 (
    set /p value="enter value to commit to the registry: "
    uwfmgr registry commit %registryKey% %value%
    pause
    cls
    goto :registryMenu
) else (
    echo registry does not exist
    pause
    cls
    goto :registryMenu
)

:commitDeleteRegistry
set /p registryType="enter registry Type (HKCU, HKLM, HKU, HKCC, HKCR): "
reg query "%registryType%" >nul 2>&1
if %errorlevel%==0 (
    reg query %registryType%
)
set /p registryKey="enter registry key: "
reg query "%registryKey%" >nul 2>&1
if %errorlevel%==0 (
    set /p value="enter value to delete to the registry: "
    uwfmgr registry commit-delete %registryKey% %value%
    pause
    cls
    goto :registryMenu
) else (
    echo registry does not exist
    pause
    cls
    goto :registryMenu
)

:getOverlayConfig
uwfmgr overlay Get-config
pause
cls
goto :overlayMenu

:getAvailableSpace
uwfmgr overlay Get-AvailableSpace
pause
cls
goto :overlayMenu

:getConsumption
uwfmgr overlay Get-consumption
pause
cls
goto :overlayMenu

:setSize
set /p size="enter a size in MB for the UWF overlay: "
uwfmgr overlay set-size %size%
pause
cls
goto :overlayMenu

:setType
choice /C RD /M "set overlay storage type to RAM (R) or Disk (D)"
if %errorlevel% equ 1 (
    uwfmgr set-type RAM
    pause
    cls
    goto :overlayMenu
)
if %errorlevel% equ 2 (
    uwfmgr set-type DISK
    pause
    cls
    goto :overlayMenu
)

:setWarningThreshold
set /p size="enter a size in MB for warning notification : "
uwfmgr overlay set-warningthreshold %size%
pause
cls
goto :overlayMenu

:setCriticalThreshold
set /p size="enter a size in MB for critical notification : "
uwfmgr overlay set-criticalthreshold %size%
pause
cls
goto :overlayMenu

:setpassthrough
choice /C OF /M "do you want to turn free space passthrough ON (O) or OFF (F)"
if %errorlevel% equ 1 (
    uwfmgr overlay set-passthrough on
)
if %errorlevel% equ 2 (
    uwfmgr overlay set-passthrough off
)
pause
cls
goto :overlayMenu

:setPersistent
choice /C OF /M "do you want to turn persistent overlay ON (O) or OFF (F)"
if %errorlevel% equ 1 (
    uwfmgr overlay set-persistent on
)
if %errorlevel% equ 2 (
    uwfmgr overlay set-persistent off
)
pause
cls
goto :overlayMenu

:resetPersistent
choice /C OF /M "do you want to turn reset persistent overlay ON (O) or OFF (F)"
if %errorlevel% equ 1 (
    uwfmgr overlay reset-persistentstate on
)
if %errorlevel% equ 2 (
    uwfmgr overlay reset-persistentstate off
)
pause
cls
goto :overlayMenu


:getServcingConfig
uwfmgr servicing get-config
pause
cls
goto :servicingMenu

:enableServicing
uwfmgr servicing enable
pause
cls
goto :servicingMenu

:disableServicing
uwfmgr servicing disable
pause
cls
goto :servicingMenu

:updateWindows
uwfmgr servicing update-windows
pause
cls
goto :servicingMenu


:exit
exit