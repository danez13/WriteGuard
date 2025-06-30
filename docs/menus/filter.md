# Filter Management Menu

The **Filter Menu** in WriteGuard allows you to enable, disable, and check the status of the Unified Write Filter (UWF)

## Accessing the Filter Menu

From the main menu of `writeguard.bat` press `F`

---

## Options

### Enable Filter: `E`
This turns **UWF** on.

Once enabled, changes to protect volumes will be discarded after a reboot

!!! important
    After enabling the filter, you must **reboot** for it to take effect

### Disable Filter: `D`
This turns **UWF** off

Once enabled permanent changes can be made to protected volumes

!!! warning
    Disabling the filter exposes the system to permanent changes

### Reboot: `R`
Reboots the system. This is often required after enabling or disabling the filter to apply

### Return to main Menu: `B`
Go back to the main menu

---

## Notes
- You must enable UWF before protecting volums
- Changes made to protected volumes while UWF is enabled will be discard on reboot
