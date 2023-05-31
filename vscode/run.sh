#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")
EXTENSIONS_FILE="${BASEDIR}/extensions.txt"

# Create symlinks
ln -sfv "${BASEDIR}/settings.json" "${HOME}/Library/Application Support/Code/User"

# Install extensions
while read -r EXTENSION; do
    code --install-extension "${EXTENSION}"
done < "${EXTENSIONS_FILE}"
