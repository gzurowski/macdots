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
CLEANUP_DIR="${BASEDIR}/downloads_cleanup"
chmod +x "${CLEANUP_DIR}/downloads_cleanup.sh"

# Create app bundle for better macOS integration (Info.plist already exists in the bundle)
APP_DIR="${CLEANUP_DIR}/DownloadsCleanup.app"
mkdir -p "${APP_DIR}/Contents/MacOS"
ln -sf "${CLEANUP_DIR}/downloads_cleanup.sh" "${APP_DIR}/Contents/MacOS/cleanup_downloads"

# Install LaunchAgent
ln -sfv "${CLEANUP_DIR}/downloads_cleanup.plist" "${HOME}/Library/LaunchAgents/org.zurowski.cleanup_downloads.plist"

# Load the LaunchAgent using modern approach
SERVICE_NAME="org.zurowski.cleanup_downloads"
if ! launchctl list | grep -q "$SERVICE_NAME"; then
    echo "Loading $SERVICE_NAME..."
    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/${SERVICE_NAME}.plist
else
    echo "$SERVICE_NAME already loaded"
fi
