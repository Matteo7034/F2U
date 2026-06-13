

install_gdm(){
  msg "GDM theme Installation..."

  if [[ -d gdm ]]; then
    cp -r gdm/* /usr/share/gnome-shell/theme/
    gdm-tools apply /usr/share/themes/Yaru
  else
    msg "GDM custom theme not found, skip."
  fi
}

