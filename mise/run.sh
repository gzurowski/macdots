#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

mkdir -p "${HOME}/.config/mise"

# Create symlinks
ln -sfv "${BASEDIR}/config.toml" "${HOME}/.config/mise"

# Update plugins
mise plugin update

# Install tools
mise install
