#!/usr/bin/env bash
set -ex

# Path to Homebrew's zsh:
# On Intel Macs, this is `/usr/local/bin/zsh`.
# On Apple Silicon Macs, this is `/opt/homebrew/bin/zsh`.
ZSH_PATH="/opt/homebrew/bin/zsh"

# Install oh-my-zsh if not present
if ! test -d "$HOME/.oh-my-zsh"; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Update oh-my-zsh
"$HOME/.oh-my-zsh/tools/upgrade.sh"

# Add Homebrew's zsh to /etc/shells, so it can be made the default shell
if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

# Make Homebrew's zsh the default shell if it isn't already
if ! test "$SHELL" = "$ZSH_PATH"; then
    chsh -s "$ZSH_PATH"
fi
