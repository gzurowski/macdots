#!/usr/bin/env bash
set -e

BASEDIR=$(dirname "$(readlink -f "$0")")
FIREFOX_PROFILES_DIR="${HOME}/Library/Application Support/Firefox/Profiles"

for PROFILE in "$FIREFOX_PROFILES_DIR"/*/; do
    echo "Configuring profile: $(basename "$PROFILE")"
    ln -sfv "${BASEDIR}/user.js" "${PROFILE}user.js"
done
