
apply_ptyxis_theme() {
    REAL_USER=$(logname)
    USER_BUS="/run/user/$(id -u $REAL_USER)/bus"
    ENV="DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=$USER_BUS"

    msg "Applying Ubuntu theme to Ptyxis..."
    runuser -l "$REAL_USER" -c "$ENV bash -c \"UUID=\\\$(gsettings get org.gnome.Ptyxis default-profile-uuid | tr -d \\\"'\\\"); gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/\\\$UUID/ palette 'Ubuntu'\""

    msg "Ptyxis theme set to Ubuntu."
}
