# Volume Management Menu

The **Volume Menu** in WriteGuard lets you protect or unprotect specific volumes using the Unified Write Filter (UWF), and view their current configuration.

---

## Accessing the Volume Menu

From the main menu of `writeguard.bat`, press `V`.

---

## Options

### Protect Volume: `P`
Adds UWF protection to a volume.

You’ll be prompted to:
- Press `1` to protect a **single** volume (recommended)
- Press `A` to protect **all** volumes

!!! note
    Protecting a volume means all changes to it will be discarded after a reboot while UWF is enabled.

### Unprotect Volume: `U`
Removes UWF protection from a volume.

You’ll be prompted to select the drive letter. Once unprotected, changes to that volume will be **persisted**.

!!! warning
    Unprotecting critical system volumes can make your system vulnerable to unwanted changes.

### View Volume Config: `D`
Displays UWF configuration for one or all protected volumes:

- Press `1` to display one volume
- Press `A` to display all volumes

### Reboot: `R`
Restarts the system to apply protection changes.

### Return to Main Menu: `B`
Returns to the main menu.

---

## Notes

- You must enable the filter (`F > E`) before protecting volumes.
- It’s best to protect only required volumes, such as system or application drives.
- Always reboot after adding or removing volume protection.
