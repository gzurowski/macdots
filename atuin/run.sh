#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

mkdir -p "${HOME}/.config/atuin"

# Create symlinks
ln -sfv "${BASEDIR}/config.toml" "${HOME}/.config/atuin"
