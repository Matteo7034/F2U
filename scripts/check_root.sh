
check_root(){
  if [[ $EUID -ne 0 ]]; then
      err "Run this script with sudo or root."
  fi
}
