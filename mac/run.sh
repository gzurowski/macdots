#!/usr/bin/env bash
set -e

# Enable Touch ID for sudo on Silicon Macs
if test "$(uname -m)" = "arm64" && \
    ! grep -Eq "auth\s+sufficient\s+pam_tid.so" /etc/pam.d/sudo; then
    echo "Enabling Touch ID for sudo..."
    sudo sed -i '.bak' "2s/^/# Enable Touch ID for sudo:\nauth       sufficient     pam_tid.so\n/" /etc/pam.d/sudo
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
