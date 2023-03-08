#!/usr/bin/env bash
set -e
BREWFILE="$(dirname $0)/Brewfile"
BREW_PATH="/opt/homebrew"

# Install Homebrew
if ! test -d "$BREW_PATH"; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew
brew update

# Install all packages from Brewfile
brew bundle --file "${BREWFILE}"
