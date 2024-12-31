#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$(readlink -f "$0")")

ln -sfv "${BASEDIR}"/config "${HOME}/Library/Application Support/com.mitchellh.ghostty/"
