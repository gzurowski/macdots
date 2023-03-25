#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Create symlinks
ln -sfv "${BASEDIR}/vscode/settings.json" "${HOME}/Library/Application Support/Code/User"
