# UWF
## Summary
A batch file that runs microsoft Unified Write Filter (UWF) commands through a interface to make it easier for a user to run the commands

## Features
there are 6 Menus that are available from the starting menu, each menu presents a sub-interface for each sub-command available to the UWF commandline tool

each sub-menu offers each possible sub-command that the Unified Write Filter Manager tool (UWFMGR) has available

the following sub-commands are available from the UWFMGR tool and are therefore available from the batch interface:
1. Filter
2. Volume
3. File
4. Registry
5. Overlay
6. Servicing

## sub-commands/ sub-menus
the following dwelves deeper into each sub-menu dedicated to each subcommand and the operations that they perform

### Filter
Enables or disables UWF, resets configuration settings for UWF and shuts down or restarts your device
- **Enable**
    - Enables the UWF protection for the next session after system restart
    - During this operation various things are also done through the interface
        - the program enables the deviceLockdown and the unified write filter feature from the windows system feature
            - this is important in order to have access to the UWFMGR command-line tool
        - proceeding this UWF is enabled for the system through the UWFMGR command tool
- **Disable**
    - Disables UWF protection for the next session after a system restart
    - the system features enabled during the enable operation are not disabled during disable operation due to the need to might disable UWF inorder to perform other operations avalable through the interface
- **Restart**
    - restarts the system

### Volume
configures settings for volumes protected by UWF
- **Get Config**
    - displays configuration settings and file exclusions for the specified volume or all volumes
    - Displays information for both the current and next session
    - the parameters available:
        - < volume > 
            - a volume can be specified to display the specific volume configurations and file exclusions
        - all
            - every available to the system will be display volume configurations and file exclusions
- **Protect**
    - adds the specified volume or all volumes to the list of volumes that are protected by UWF.
    - UWF starts protecting the volume after after a system reset
    - the parameters available are
        - < volume >
            - specify volume available to the system to protect
        - all
            - every volume available to the system will be protected
- **Unprotect**
    - removes the specified volume from the list of volumes that are protected by UWF
    - UWF stops protecting the volume after the next system restart
    - parameter:
        - < volume >
            - specify volume currently protected that will be unprotected
- **Restart**
    - restart the system

### File
Configures file exclusiion settings for UWF.
- **Get Exclusions**
    - Displays all files and directories in the exclusion list for the specified volume or all volumes
    - Displays all information for both the current and next session
    - options available:
        - < volume >
            - specify the volume that will display file and directory exclusions
        - all
            - all volumes will display file and directory exclusions
- **Add Exclusion**
    - adds the specified file to the file exclusion list of the volume protected by UWF
    - UWF starts excluding the file from the filitering after the next system restart
    - parameter:
        - < file >
            - A string that contains the full path of the file or folder relative to the volume.
- **Remove Exclusion**
    - Removes the specified file from the file exclusion list of the volume protected by UWF
    - UWF stops excluding the file from filtering after the next system restart
    - parameter:
        - < file >
            - A string that contains the full path of the file or folder relative to the volume.
- **Commit**
    - commits changes from the overlay to the physica volume for a specified file on a volume protected by UWF
    - parameter:
        - < file >
            - A string that contains the path of the file to commit on the overlay
- **Commit Deletion**
    - Deletes the specified file and commits the deletion to the physical volume
    - parameter:
        - < file >
            - sA string that contains the path of the file to delete
- **Restart**
    - restarts the system
### Registry
configures registry key exclusion settings for UWF
- **Get Exclusions**
    - Displays all registry keys in the registry exclusion list
    - Displays all information about the current and next session
- **Add Exclusion**
    - Adds the specified registry key to the registry exclusion list for UWF.
    - UWF starts excluding the registry key from filtering after the next system restart
    - parameter:
        - < key >
            - A string that contains the full path of the registry key.
- **Remove Exclusion**
    - removes the specified registry key from the registry exclusion list for UWF
    - UWF stops excuding the registry key from filtering after the next system restart
    - parameter:
        - < key >
            - A string that contains the full path of the registry key.
- **Commit**
    - commits changes to the specified key and value
    - parameter:
        - < key >
            - A string that contains the full path of the registry key to be committed.
        - < value >
            - A string that contains the name of the value to be committed.
- **Commit Deletion**
    -   Deletes the specified registry key or registry value and commits the deleteion
    - parameters:
        - < key >
            - A string that contains the full path of the registry key that contains the value to be deleted. 
            - If ValueName is empty, the entire registry key is deleted.
        - < value >
            - A string that contains the name of the value to be deleted.
- **Restart**
    - restarts the system
### Overlay
Configures settings for the UWF overlay
- **Get Config**
    - Displays configuration settings for the UWF overlay
    - Displays information for both the current and the next session
- **Get Available Space**
    - Displays the amount of space remaining that is available for the UWF overlay
- **Get Consumption**
    - Displays the amount of space currently used by the UWF overlay
- **Set Size**
    - Sets the maximum size of the UWF overlay, in megabytes
    - for the next session after a system restart
    - parameter:
        - < size >
            - An integer that represents the maximum cache size, in megabytes, of the overlay.
- **Set Type**
    - Sets the type of the overlay storage to Ram-based or DISK-based
    - UWF must be disabld in the current session to tset the overlay type to disk-based
    - options available:
        - RAM
            - RAM-based storage
        - DISK
            - DISK-based storage
- **Set Warning Threshold**
    - Sets the overlay size, in megabytes, at which the driver issues warning notifications for the current session
    - parameter:
        - An integer that represents the size, in megabytes, of the warning threshold level for the overlay. 
        - If size is set to 0 (zero), UWF does not raise warning threshold events.
- **Set Critical Threshold**
    - sets the overlay size, in megabytes, at which the driver issues critical notification for the current session
    - parameter: 
        - An integer that represents the size, in megabytes, of the critical threshold level for the overlay. 
        - If size is 0 (zero), UWF does not raise critical threshold events.
- **Set Passthrough**
    - Turns the free space passthrough on or off
    - allowing UWF to use free space outside of the reserved space when available
    - options available
        - ON
            - turn on freespace passthrough
        - OFF
            - turn off freespace passthrough
- **Set Persistent**
    - sets the overlay as a persistent overlay allowing users to keep using their data after a reboot
    - options available
        - ON
            - turn on persistent overlay
        - OFF
            - turn off persistent overlay
- **Reset Persistent State**
    - clears a persistent overlay on the next boot
    - options available
        - ON
            - turn on persistent reset overlay
        - OFF
            - turn off peristent reset overlay
- **Restart**
    - restarts the system
### Servicing
Configurings settings for UWF servicing mode
- **Get Config**
    - Displays the UWF servcing mode information for the both the current session and the next session
- **Enable**
    - Enables the UWF servicing mode 
    - available in the next session after a restart
- **Disable**
    - Disables UWF servcing mode
    - available in the next session after a restart
- **Update windows**
    - Stand-alone operation to apply windows updates to a device
    - Recommended to enable the servicing mode whenever possible