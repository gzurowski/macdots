#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$(readlink -f "$0")")

mkdir -p "${HOME}/.config/ghostty"

ln -sfv "${BASEDIR}"/config "${HOME}/.config/ghostty/config"
