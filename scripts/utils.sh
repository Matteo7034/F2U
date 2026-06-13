#Depndecy check
check_dep() {
    command -v "$1" >/dev/null 2>&1
}

# install dependecy (DNF)
install_dep() {
    local pkg="$1"
    msg "Installing dependency: $pkg"
    sudo dnf install -y "$pkg" || err "Failed to install $pkg"
}


# Ensure dependecy exist 
require() {
    local bin="$1"
    local pkg="$2"

    if ! check_dep "$bin"; then
        install_dep "$pkg"
    fi
}
