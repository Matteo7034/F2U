
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
        runuser -l "$REAL_USER" -c "$ENV gsettings set org.gnome.desktop.background picture-uri-dark "file:///../../wallpapers/jelly.png""
        break
        ;;
      esac
    
    else
      msg "Incorrect Number please insert from 0 to 1"
    fi
  done
}
