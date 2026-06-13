
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
