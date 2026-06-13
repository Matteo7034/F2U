# Fedora 44 to Ubuntu theme setup


![License](https://img.shields.io/badge/license-GPL--2.0-blue)
![Fedora](https://img.shields.io/badge/Fedora-44+-blue)
![GNOME](https://img.shields.io/badge/GNOME-50-orange)

A small script to transform the Fedora workstation theme into Ubuntu LTS.

![Screen](screenshots/screen.png)

## ✨ Features
- Theme **Yaru Dark** (GTK3/GTK4 + Shell) 🌑
- Yaru Icons (light/dark) "Default Dark" 🎲
- Ubuntu Dock (Dash-to-Dock)
- Ubuntu Wallpapers optional (work in progress) 🌇
- Accent Color orange 🟠
- Plymouth Support (Ubuntu theme)
- Automated Script 🚗
- Yaru Sounds! 🔊
---

## 📦 Requirements
- Fedora 44 📘
- Gnome 50
- Internet Connection (dnf packages) 🌐
- sudo privilages 🔨

## 🚀 Installation
```bash
git clone https://github.com/Matteo7034/F2U.git
cd F2U
sudo ./install.sh
```
## 🧩 What the script does
- Automatically install Yaru themes 👕

- Enable and configure Dash-to-Dock

- Set GTK, Shell, and icon themes

- Apply orange accent color 🟠

- (Optional) Set Ubuntu wallpaper

- Install Plymouth Ubuntu theme ♾️

- Setup Terminal Theme 💻

- Setup yaru audio 🔊

- Install gnome-extension for dash to dock

## ⚠️ Small issue (Wayland sessions)

If Dash to Dock doesn't appear after the first installation, it's normal on Wayland:  
GNOME Shell does not reload user extensions until the session is restarted.

### ✅ Fix
Log out and log back in, then reinstall using the script:

```bash
cd F2U
sudo ./install.sh
```

### ℹ️ Why this happens
On Wayland, GNOME Shell cannot be reloaded (no `Alt+F2 → r`), so newly installed
user extensions are not detected until the session restarts.



## 📁 Project structure
![Tree](screenshots/tree.jpeg)

## 🔗 Quick access
- [install.sh](install.sh)
- [plymouth/ubuntu-logo](plymouth/ubuntu-logo)

## 🛠  Uninstall
(In development)
The uninstall.sh script will restore Fedora's original themes and settings. 

## 🛣 Roadmap
- [X] Sound support
- [X] Terminal support
- [X] Dash to dock
- [ ] Uninstall script
- [X] Icon Support
- [ ] Full GDM support
- [ ] Font Support
- [ ] Lock Screen Support

## 📜  License

This project is licensed under the GPL‑2.0 license.

