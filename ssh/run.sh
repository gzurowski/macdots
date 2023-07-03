#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$(readlink -f "$0")")

# Create config directory
mkdir -p "${HOME}/.ssh"

# Create symlinks
ln -sfv "${BASEDIR}/ssh/config" "${HOME}/.ssh"
