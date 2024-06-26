#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Create symlinks
ln -sfv "${BASEDIR}/zshrc" "${HOME}/.zshrc"

# Path to Homebrew's zsh
ZSH_PATH="$(brew --prefix)/bin/zsh"

# Install oh-my-zsh if not present
if ! test -d "$HOME/.oh-my-zsh"; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Symlink custom aliases
ln -sfv "${BASEDIR}/aliases.zsh" "${HOME}/.oh-my-zsh/custom/aliases.zsh"

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
if ! test "$(dscl . -read "$HOME" UserShell | awk '{print $2}')" = "$ZSH_PATH"; then
    chsh -s "$ZSH_PATH"
fi

# fzf keybinding and completions
if ! test -f "$HOME/.fzf.zsh"; then
    echo "Installing fzf keybinding and completions..."
    "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-bash --no-update-rc
fi

# Set up zsh-abbr abbreviations
zsh -ic "abbr import-git-aliases --user --prefix 'git '" 2>&1 | grep -v "already exists" || true
zsh -ic "abbr import-aliases --user" 2>&1 | grep -v "already exists" || true

exec $ZSH_PATH
