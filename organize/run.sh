#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Create symlinks
ln -sfv "${BASEDIR}/config.yaml" "${HOME}/Library/Application Support/organize"
