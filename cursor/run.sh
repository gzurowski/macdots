#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")
EXTENSIONS_FILE="${BASEDIR}/../vscode/extensions.txt"

# Create symlinks
ln -sfv "${BASEDIR}/settings.json" "${HOME}/Library/Application Support/Cursor/User"

# Install extensions
while read -r EXTENSION; do
    if [[ "${EXTENSION}" == github.copilot* ]]; then
        echo "Skipping Copilot extension ${EXTENSION}"
        continue
    fi
    cursor --install-extension "${EXTENSION}"
done < "${EXTENSIONS_FILE}"
