#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Enable Touch ID for sudo
SUDO_LOCAL="/etc/pam.d/sudo_local"
if [ ! -f "$SUDO_LOCAL" ] || ! grep -q "pam_tid.so" "$SUDO_LOCAL"; then
    echo "Enabling Touch ID for sudo..."
    echo "auth       sufficient     pam_tid.so" | sudo tee "$SUDO_LOCAL" > /dev/null
fi

# Disable creation of DS_Store files
# ... on network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# ... on USB drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Install Rosetta
if test "$(uname -m)" = "arm64" && \
    ! pgrep -q oahd; then
    echo "Installing Rosetta..."
    sudo softwareupdate --install-rosetta --agree-to-license
fi

# Downloads cleanup script
bash "${BASEDIR}/downloads_cleanup/install.sh"
