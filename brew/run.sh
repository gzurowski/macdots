#!/usr/bin/env bash
set -ex
BREWFILE="$(dirname $0)/Brewfile"

# Install Homebrew
if test ! $(which brew); then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
brew update

# Install all packages from Brewfile
brew bundle --file "${BREWFILE}"
