# Registry Exclusions Menu

The **Registry Exclusions Menu** in WriteGuard allows you to make registry keys persistent even while UWF is enabled. This is useful for preserving specific system or application settings across reboots.

---

## Accessing the Registry Menu

From the main menu of `writeguard.bat`, press `R`.

---

## Options

### Get Registry Exclusions: `G`
Lists all registry keys currently excluded from UWF protection.

Use this to review what registry changes are persistent.

### Add an Exclusion: `A`
Adds a registry key to the list of exclusions.

You’ll be prompted to enter the full registry path, e.g.:
```
HKEY_LOCAL_MACHINE\SOFTWARE\MyApp
```

!!! note
    Be precise, incorrect paths will result in errors or no effect.

### Remove an Exclusion: `K`
Removes a registry key from the exclusion list.

You’ll need to enter the same full registry path used during addition.

### Reboot: `R`
Reboots the system to apply changes.

### Return to Main Menu: `B`
Returns to the main menu.

---

## Notes

- Only certain registry hives are supported: `HKEY_LOCAL_MACHINE` and `HKEY_CLASSES_ROOT`.
- Registry exclusions are powerful — use caution when excluding security- or system-critical keys.
- Registry changes to excluded keys are saved even when UWF is active.
