# File Exclusions Menu

The **File Exclusions Menu** in WriteGuard allows you to specify individual files or folders that should be excluded from UWF protection. This is useful for allowing persistent changes to specific data on a protected volume.

---

## Accessing the File Menu

From the main menu of `writeguard.bat`, press `E`.

---

## Options

### Get Volume Exclusions: `G`
Displays a list of currently excluded files or directories.

- Press `1` to view exclusions for a single volume
- Press `A` to view exclusions for all volumes

### Add an Exclusion: `A`
Add a file or folder to the list of UWF exclusions.

You’ll be prompted to enter the full path, e.g.:

```
C:\Path\To\File.txt

D:\Path\To\Folder\
```

!!! note
    Use folder exclusions carefully — everything inside will be excluded from protection.

### Remove an Exclusion: `K`
Remove a previously added file or folder from UWF exclusions.

You'll be asked to specify the exact path again.

### Commit File: `C`
Commits the current version of a specified file or folder permanently.

Changes will be saved even if UWF is enabled.

### Delete Committed File: `D`
Deletes a previously committed file or folder from the commit history.

This does **not** delete the file itself — only the commit record.

### Reboot: `R`
Restarts the system to apply any changes.

### Return to Main Menu: `B`
Returns to the main menu.

---

## Notes

- Only paths on **protected volumes** can be excluded.
- Use file commits for updates you want to retain without disabling the filter.
- Always verify the path you enter for exclusions to avoid errors.
