#!/usr/bin/env bash
set -ex

# Path to Homebrew's zsh
ZSH_PATH="/usr/local/bin/zsh"

# Install oh-my-zsh if not present
if ! test -d "$HOME/.oh-my-zsh"; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Add Homebrew's zsh to /etc/shells, so it can be made the default shell
if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

# Make Homebrew's zsh the default shell
chsh -s $ZSH_PATH
