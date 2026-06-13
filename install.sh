#!/bin/bash

set -euo pipefail

msg() { printf "\n[+] %s\n " "$1"; }
err() { printf "\n[+] ERROR: %s\n" "$1"; exit 1; }



source scripts/utils.sh
source scripts/check_root.sh
source scripts/deps.sh

source scripts/modules/wallpaper.sh
source scripts/modules/plymouth.sh
source scripts/modules/souds.sh
source scripts/modules/settings.sh
source scripts/modules/terminal.sh
source scripts/modules/gdm.sh
source scripts/modules/extentions.sh


main(){
    check_root
    msg "Starting F2U installation..."

    install_deps
    install_packages
    install_themes
    dash_to_dock
    apply_gnome_settings
    wallpaper
    install_plymouth
    apply_ptyxis_theme
    apply_yaru_sounds
    #install_gdm

    msg "Installation complete! Reboot to apply all changes."
}
main "$@"
