# Servicing Mode Menu

**Servicing Mode** allows administrators to temporarily disable UWF protections after a reboot. This is useful for applying updates, installing software, or making system changes without permanently disabling the filter.

---

## Accessing the Servicing Mode Menu

From the main menu of `writeguard.bat`, press `S`.

---

## Options

### Enable Servicing Mode: `E`
Schedules UWF to **enter servicing mode** after the next reboot.

In this mode:
- UWF is temporarily disabled.
- All changes made are **persistent**.
- On the following reboot, UWF will be **enabled** again automatically.

!!! important
    You must **reboot** for servicing mode to take effect.

### Disable Servicing Mode: `D`
Cancels servicing mode if it was previously scheduled but not yet activated.

### Check Servicing Mode Status: `C`
Displays the current status of servicing mode:
- Whether it's enabled now.
- Whether it’s scheduled for the next boot.

### Reboot: `R`
Reboots the system to apply changes or enter servicing mode.

### Return to Main Menu: `B`
Returns to the main menu.

---

## Notes

- **Servicing Mode is ideal** for scheduled maintenance without permanently turning off UWF.
- After using servicing mode, always confirm UWF is re-enabled on the next boot.
- If you need to make repeated changes, consider disabling UWF directly instead.
