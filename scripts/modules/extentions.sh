
dash_to_dock(){
    msg "Installing Dash to Dock..."
    require unzip unzip
    require gnome-extensions gnome-extensions-app
    gnome-extensions install -f $HOME/F2U/assets/dash-to-dock@micxgx.gmail.com.zip
    gnome-extensions enable dash-to-dock@micxgx.gmail.com
}
