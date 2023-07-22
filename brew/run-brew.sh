#!/usr/bin/env bash
set -e
BREW_FILE="$1"
BREW_PATH="/opt/homebrew" # Apple Silicon
if test "$(uname -m)" = "x86_64"; then
    BREW_PATH="/usr/local" # Intel
fi

echo "Homebrew: $BREW_PATH"
echo "Brewfile: $BREW_FILE"

# Install Homebrew
if ! test -f "$BREW_PATH/bin/brew"; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Set Homebrew environment if not already set
if test -d "$BREW_PATH"; then
    eval "$("${BREW_PATH}"/bin/brew shellenv)"
fi

# Update Homebrew
brew update

# Update all packages
brew upgrade

# Install all packages from Brewfile
brew bundle --file "${BREW_FILE}"

# Remove all packages not listed in Brewfile
brew bundle cleanup --file "${BREW_FILE}" --force
