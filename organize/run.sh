#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Create symlinks
mkdir -p "${HOME}/.config/organize"
ln -sfv "${BASEDIR}/config.yaml" "${HOME}/.config/organize/"

# Install LaunchAgent
ln -sfv "${BASEDIR}/org.zurowski.organize.plist" "${HOME}/Library/LaunchAgents/org.zurowski.organize.plist"

# Load the LaunchAgent
SERVICE_NAME="org.zurowski.organize"
if ! launchctl list | grep -q "$SERVICE_NAME"; then
    echo "Loading $SERVICE_NAME..."
    launchctl bootstrap gui/"$(id -u)" ~/Library/LaunchAgents/${SERVICE_NAME}.plist
else
    echo "$SERVICE_NAME already loaded"
fi
