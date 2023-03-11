#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Create symlinks
ln -sfv "${BASEDIR}/zshrc" "${HOME}/.zshrc"

# Path to Homebrew's zsh
ZSH_PATH="/opt/homebrew/bin/zsh" # Apple Silicon
if test "$(uname -m)" = "x86_64"; then
    ZSH_PATH="/usr/local/bin/zsh" # Intel
fi

# Install oh-my-zsh if not present
if ! test -d "$HOME/.oh-my-zsh"; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Symlink custom aliases
ln -sfv "${BASEDIR}/aliases.zh" "${HOME}/.oh-my-zsh/custom/aliases.zh"

# Update oh-my-zsh
"$HOME/.oh-my-zsh/tools/upgrade.sh"

# Add Homebrew's zsh to /etc/shells, so it can be made the default shell
if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "Adding $ZSH_PATH to /etc/shells..."
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

# Make Homebrew's zsh the default shell if it isn't already.
# Use `dscl` instead of the `$SHELL` variable, because it might not yet be set
# after switching the default shell with `chsh`.
if ! test "$(dscl . -read $HOME UserShell | awk '{print $2}')" = "$ZSH_PATH"; then
    chsh -s "$ZSH_PATH"
fi
