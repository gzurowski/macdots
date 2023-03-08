#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$(readlink -f "$0")")

# Create symlinks
ln -sfv "${BASEDIR}/gitconfig" "${HOME}/.gitconfig"
ln -sfv "${BASEDIR}/gitignore_global" "${HOME}/.gitignore_global"
