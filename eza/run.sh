#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$(readlink -f "$0")")

mkdir -p "${HOME}/.config/eza"

# Create symlinks
ln -sfv "${BASEDIR}/eza/theme.yml" "${HOME}/.config/eza/theme.yml"
