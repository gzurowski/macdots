#!/usr/bin/env bash
set -e

BASE_DIR=$(dirname "$(readlink -f "$0")")
BREW_FILE="${BASE_DIR}/Brewfile"

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    BREW_PATH=$(command -v brew)
    eval "$(${BREW_PATH} shellenv)"
fi

# Update Homebrew
brew update

# Update all packages
brew upgrade

# Install all packages from Brewfile
brew bundle --file "${BREW_FILE}"

# Remove all packages not listed in Brewfile
brew bundle cleanup --file "${BREW_FILE}" --force
