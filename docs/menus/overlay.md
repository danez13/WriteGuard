# Overlay Settings Menu

The **Overlay Menu** in WriteGuard allows you to view and configure how UWF stores temporary changes. The overlay can be stored in RAM or on disk and has configurable thresholds.

---

## Accessing the Overlay Menu

From the main menu of `writeguard.bat`, press `O`.

---

## Options

### Get Overlay Config: `G`
Displays the current UWF overlay configuration, including storage type, size, and thresholds.

### Get Available Space: `A`
Shows how much space is left in the UWF overlay.

### Get Consumption: `C`
Displays current overlay usage.

### Set Size: `S`
Sets the maximum size of the overlay in **megabytes (MB)**.

!!! warning
    If the overlay fills up, the system may become unresponsive.

### Set Storage Type: `T`
Choose where the overlay is stored:
- `RAM`: Faster, but limited size.
- `Disk`: Slower, but allows more space.

### Set Warning Threshold: `W`
Sets a warning level for overlay usage. A notification can be triggered when this threshold is reached.

### Set Critical Threshold: `L`
Sets a critical limit for overlay usage. Reaching this may result in system instability.

### Toggle Free Space Passthrough: `P`
Controls whether UWF reports actual or overlay-limited free space.

- `ON`: Shows full drive space (including overlay).
- `OFF`: Shows only what's available in overlay.

### Toggle Persistent Overlay: `O`
When enabled, overlay data persists across reboots. Useful for testing.

### Reset Persistent Overlay: `I`
Clears the persistent overlay state.

### Reboot: `R`
Reboots the system to apply overlay changes.

### Return to Main Menu: `B`
Returns to the main menu.

---

## Notes

- **Overlay space** is where temporary changes are stored while UWF is active.
- Keeping an eye on **consumption** and **thresholds** helps prevent crashes.
- Use **persistent overlays** carefully — they may give a false sense of data being saved.
