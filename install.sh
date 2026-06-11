#!/bin/bash


set -euo pipefail

msg() { printf "\n[+] %s\n " "$1"; }
err() { printf "\n[+] ERROR: %s\n" "$1"; exit 1; }

check_root(){
  if [[ $EUID -ne 0 ]]; then
      err "Run this script with sudo or root."
  fi
}

install_deps(){
  msg "Installing of necessary dependecies..."
  dnf update
  flatpak install flathub com.mattjakeman.ExtensionManager
  dnf install -y \
        git \
        gnome-shell-extension-appindicator \
        gnome-shell-extension-dash-to-dock \
        gnome-tweaks \
        plymouth-theme-spinner \
        sassc \
        libsass \
        make \
        gcc \
        plymouth-plugin-script \
        unzip
        #gdm-tools 
        
}
dash_to_dock(){
  wget https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v90.shell-extension.zip -O dash-to-dock.zip
  mkdir -p ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
  unzip dash-to-dock.zip -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com
}
install_themes() {
  msg "Installing Yaru themes..."
  dnf install -y \
        yaru-theme \
        yaru-gtk3-theme \
        yaru-gtk4-theme \
        yaru-icon-theme \
        yaru-sound-theme \
        gnome-shell-theme-yaru
  msg "Yaru themes installed successfully."
}

apply_gnome_settings(){
    msg "Ubuntu Style gnome configuration..."
    REAL_USER=${SUDO_USER:-$(whoami)}
    # Ubuntu Dock
    #gnome-extensions enable dash-to-dock@micxgx.gmail.com
    
    DP="DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/\$(id -u)/bus "    
    runuser -l "$REAL_USER" -c  "$DP gnome-extensions enable dash-to-dock@micxgx.gmail.com; \
        $DP gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'; \
        $DP gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true; \
        $DP gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48; \
        $DP gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"; \
        $DP gsettings set org.gnome.shell.extensions.user-theme name "Yaru-dark"; \
        $DP gsettings set org.gnome.desktop.interface icon-theme "Yaru-dark"; \
        $DP gsettings set org.gnome.desktop.interface accent-color 'orange'; " 
}

install_plymouth() {
  msg "Plymouth theme installation..."
  if [[ -d plymouth/ubuntu-logo ]]; then
      cp -r plymouth/ubuntu-logo /usr/share/plymouth/themes/ubuntu-logo
      plymouth-set-default-theme -R ubuntu-logo
  else
      msg "Plymouth custom theme not found, skip."
  fi
  
}

install_gdm(){
  msg "GDM theme Installation..."

  if [[ -d gdm ]]; then
    cp -r gdm/* /usr/share/gnome-shell/theme/
    gdm-tools apply /usr/share/themes/Yaru
  else
    msg "GDM custom theme not found, skip."
  fi
}
wallpaper(){
  REAL_USER=$(logname)
  USER_BUS="/run/user/$(id -u $REAL_USER)/bus"
  ENV="DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=$USER_BUS"

  local WALLPAPER=("$PWD/wallpapers/*.{png,jpg,jpeg}")
  msg "Choose a wallpaper..."
  msg "[0]: Don't change wallpaper."
  msg "[1]: Jellyfish Ubuntu."
  msg "Insert a number from 0-1"
  local NUMERO=""
  
  while (true);do
    read -r NUMERO
    if [[ "$NUMERO" =~ ^[0-1]$ ]]; then
      case "$NUMERO" in
        0)
        break
        ;;
        1)
        runuser -l "$REAL_USER" -c "$ENV gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
        runuser -l "$REAL_USER" -c "$ENV gsettings set org.gnome.desktop.background picture-uri-dark "file:///$PWD/wallpapers/jelly.png""
        break
        ;;
      esac
    
    else
      msg "Incorrect Number please insert from 0 to 1"
    fi
  done
}

apply_ptyxis_theme() {
    REAL_USER=$(logname)
    USER_BUS="/run/user/$(id -u $REAL_USER)/bus"
    ENV="DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=$USER_BUS"

    msg "Applying Ubuntu theme to Ptyxis..."
    runuser -l "$REAL_USER" -c "$ENV bash -c \"UUID=\\\$(gsettings get org.gnome.Ptyxis default-profile-uuid | tr -d \\\"'\\\"); gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/\\\$UUID/ palette 'Ubuntu'\""

    msg "Ptyxis theme set to Ubuntu."
}
apply_yaru_sounds() {
    REAL_USER=$(logname)
    USER_BUS="/run/user/$(id -u $REAL_USER)/bus"
    ENV="DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=$USER_BUS"

    msg "Enabling Yaru sound theme..."

    # 1. Set yaru sound theme
    runuser -l "$REAL_USER" -c "$ENV gsettings set org.gnome.desktop.sound theme-name 'Yaru'"
    
    # 2. Activate system sound effect
    runuser -l "$REAL_USER" -c "$ENV gsettings set org.gnome.desktop.sound event-sounds true"
    
    # 3. Activate fallback sound Effect
    runuser -l "$REAL_USER" -c "$ENV gsettings set org.gnome.desktop.sound input-feedback-sounds true"

    msg "Yaru sound theme applied and enabled successfully."
}

main(){
    check_root
    msg "Starting F2U installation..."

    install_deps
    install_themes
    #dash_to_dock
    apply_gnome_settings
    wallpaper
    install_plymouth
    apply_ptyxis_theme
    apply_yaru_sounds
    #install_gdm

    msg "Installation complete! Reboot to apply all changes."
}
main "$@"
