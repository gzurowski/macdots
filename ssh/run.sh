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

# Remove symlinks for config_* files that no longer exist in private/ssh
for symlink in "${HOME}/.ssh/config_"*; do
    if [[ -L "$symlink" ]]; then
        filename=$(basename "$symlink")
        source_file="${ROOTDIR}/private/ssh/$filename"
        if [[ ! -f "$source_file" ]]; then
            echo "Removing orphaned symlink: $symlink"
            rm -f "$symlink"
        fi
    fi
done
