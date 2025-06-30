# Write Guard

Welcome to the documentation for **Write Guard**, a command-line tool that makes UWF configuration easier on Windows systems.



This tool offers a menu-driven interface to manage different aspects of UWF, including:

- Enabling or disabling the UWF filter  
- Protecting or unprotecting volumes  
- Managing file and registry exclusions  
- Configuring overlay settings  
- Controlling servicing mode and updates  
- Automatically turning on required Windows features, like UWF and Device Lockdown  

---

## What is UWF?

[Unified Write Filter (UWF)](https://learn.microsoft.com/en-us/windows/iot/iot-enterprise/uwf) is a feature of Windows that protects physical storage by redirecting write operations to a virtual overlay. It is often used in kiosks, ATMs, and embedded devices.

---

## Why Use This Tool?

Manually setting up UWF with `uwfmgr` commands can be tedious and prone to mistakes. This script simplifies that process with:

- Simple keyboard-based menus  
- Automatic validation of input  
- Built-in support for reboot prompts  
- Auto-activation of required Windows features  
- Full control over exclusions and overlay behavior

---

## Features Overview

- **Interactive menu system**  
- **Admin privilege elevation**  
- **Feature auto-enablement (DISM)**  
- **Volume and file protections**  
- **Overlay memory configuration**  
- **Windows servicing controls**  
- **Restart prompts when needed**

---

## Use Case Scenarios

- Setting up a **read-only Windows device**
- Creating **secure embedded systems**
- Managing **IoT devices or kiosks**
- Preparing devices for **public or high-security environments**

---

## Quick Start

> See [Getting Started](getting-started.md) for setup and execution instructions.

---

## Author

Created and maintained by **Daniel Hernandez**.  
Contributions and feedback are welcome!
