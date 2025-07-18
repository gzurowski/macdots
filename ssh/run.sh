#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$(readlink -f "$0")")
ROOTDIR=$(dirname "${BASEDIR}")

# Create config directory
mkdir -p "${HOME}/.ssh"

# Create symlinks
ln -sfv "${BASEDIR}/config" "${HOME}/.ssh"

# Iterate over all config_* files in private/ssh and create symlinks
for config_file in "${ROOTDIR}/private/ssh/config_"*; do
    if [[ -f "$config_file" ]]; then
        filename=$(basename "$config_file")
        ln -sfv "$config_file" "${HOME}/.ssh/$filename"
    fi
done
