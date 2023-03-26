#!/usr/bin/env bash
set -ex
BASEDIR=$(dirname "$(readlink -f "$0")")

# Set the iTerm2 preferences directory.
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${BASEDIR}"

# Enable iTerm2 to use the custom preference directory.
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
