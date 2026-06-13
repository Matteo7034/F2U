
install_plymouth() {
  msg "Plymouth theme installation..."
  if [[ -d plymouth/ubuntu-logo ]]; then
      cp -r plymouth/ubuntu-logo /usr/share/plymouth/themes/ubuntu-logo
      plymouth-set-default-theme -R ubuntu-logo
  else
      msg "Plymouth custom theme not found, skip."
  fi
  
}

