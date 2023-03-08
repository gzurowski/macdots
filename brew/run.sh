#!/usr/bin/env bash
set -e
BREWFILE="$(dirname $0)/Brewfile"
BREW_PATH="/opt/homebrew" # Apple Silicon
if test "$(uname -m)" = "x86_64"; then
    BREW_PATH="/usr/local" # Intel
fi

# Install Homebrew
if ! test -d "$BREW_PATH"; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Set Homebrew environment if not already set
if test -d "$BREW_PATH" && test ! $(which brew); then
    eval "$("${BREW_PATH}"/bin/brew shellenv)"
fi

# Update Homebrew
brew update

# Install all packages from Brewfile
brew bundle --file "${BREWFILE}"
