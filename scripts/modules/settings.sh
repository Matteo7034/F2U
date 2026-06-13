
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
        $DP gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'; \
        $DP gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-dark'; \
        $DP gsettings set org.gnome.desktop.interface icon-theme 'Yaru-dark'; \
        $DP gsettings set org.gnome.desktop.interface accent-color 'orange'; " 
}
