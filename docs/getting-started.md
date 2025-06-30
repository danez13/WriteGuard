# Getting Started with WriteGuard

Welcome to **WriteGuard** — a powerful batch script interface for managing the Unified Write Filter (UWF) on Windows systems. This guide will walk you through installation, configuration, and basic usage.

---

## Download

Download the latest version of **WriteGuard** from our SourceForge page:

<!-- - [Download WriteGuard on SourceForge](https://sourceforge.net/projects/your-project-name/files/latest/download) -->
- [Download WriteGuard on GitHub](https://github.com/danez13/WriteGuard)

Once downloaded, extract the `.zip` archive to a convenient location on your system.

---

## Requirements

Ensure your system meets the following:

- **OS**: Windows 10/11 Enterprise, Education, or IoT editions
- **Admin Access**: The script must be run as an administrator
- **Windows Features**:
    - Unified Write Filter (UWF)
    - Device Lockdown (optional, but recommended)

---

## Installation

### 1. Extract the Files

1. Unzip the downloaded file and open the folder.

### 2. Launch

Double-click on `writeguard.bat`

### 3. Enable filter

1. Press `F` to enter filter Menu
2. Press `E` to enable UWF
3. Press `R` to reboot

### 4. Protect Volume

1. Press `V` to enter the Volume menu
2. Press `P` to Protect a volume
   - Press `1` to protect a single volume (Recommended)
   - Press `A` to protect all volumes
3. Follow on-screen instructions to continue
4. Finished UWF has been enabled and a volume
5. Press `R` to reboot
---
## Disabling or Uninstalling

To disable UWF:

1. Run `writeguard.bat` as Administrator
2. Press `F` to enter the Filter Menu
3. Press `D` to disable UWF
4. Press `R` to reboot

To remove the script, simply delete the extracted folder.
---
## Verify UWF Status

To check if UWF is enabled after reboot:

1. Re-run `writeguard.bat` as administrator
2. Press `F` to go to the Filter Menu
3. If UWF is enabled, it will display: `Filter state: ON`
---
## Troubleshooting
- **UWF not found:** Your Windows edition may not support it, or the feature is not installed
- **Changes not saved after reboot:** UWF discards changes unless files or registry keys are committed
---
## Best Practices
- **Backup:** Always back up registry keys or files before commiting changes
- **Use menus carefully:** Avoid unprotecting critical volumes accidentally