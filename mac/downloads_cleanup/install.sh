#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Make script executable
chmod +x "${BASEDIR}/downloads_cleanup.sh"

# Create app bundle for better macOS integration (Info.plist already exists in the bundle)
APP_DIR="${BASEDIR}/DownloadsCleanup.app"
mkdir -p "${APP_DIR}/Contents/MacOS"
ln -sf "${BASEDIR}/downloads_cleanup.sh" "${APP_DIR}/Contents/MacOS/cleanup_downloads"

# Install LaunchAgent
ln -sfv "${BASEDIR}/downloads_cleanup.plist" "${HOME}/Library/LaunchAgents/org.zurowski.cleanup_downloads.plist"

# Load the LaunchAgent using modern approach
SERVICE_NAME="org.zurowski.cleanup_downloads"
if ! launchctl list | grep -q "$SERVICE_NAME"; then
    echo "Loading $SERVICE_NAME..."
    launchctl bootstrap gui/"$(id -u)" ~/Library/LaunchAgents/${SERVICE_NAME}.plist
else
    echo "$SERVICE_NAME already loaded"
fi