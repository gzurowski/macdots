#!/usr/bin/env bash
set -e

BASEDIR=$(dirname "$(readlink -f "$0")")

mkdir -p "$HOME"/.config/starship

ln -sfv "${BASEDIR}"/starship.toml "${HOME}"/.config/starship
