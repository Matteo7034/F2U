

install_packages() {
    sudo dnf install -y \
        gnome-tweaks \
        plymouth-theme-spinner \
        plymouth-plugin-script
}

install_themes() {
    sudo dnf install -y \
        yaru-theme \
        yaru-gtk3-theme \
        yaru-gtk4-theme \
        yaru-icon-theme \
        yaru-sound-theme \
        gnome-shell-theme-yaru
}
install_deps(){
  msg "Installing of necessary dependecies..."
  dnf update
  flatpak install -y flathub com.mattjakeman.ExtensionManager
  require git git
  require unzip unzip
  require gnome-extensions gnome-extensions-app
  require sassc sassc
  require make make
  require gcc gcc

  msg "Istalling packages..."
  
  install_packages

  msg "packages installaed successfully."
        
  msg "Installing Yaru themes..."

  install_themes
  
  msg "Yaru themes installed successfully."
}
