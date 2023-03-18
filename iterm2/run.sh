#!/usr/bin/env bash
set -ex

BASEDIR=$(dirname "$(readlink -f "$0")")
ITERM2_PATH="${HOME}/.iterm2"

mkdir -p "${ITERM2_PATH}"

# Create symlinks
ln -sfv "${BASEDIR}/iterm2.plist" "${ITERM2_PATH}/com.googlecode.iterm2.plist"

# Set the iTerm2 preferences directory.
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${ITERM2_PATH}"

# Enable iTerm2 to use the custom preference directory.
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
