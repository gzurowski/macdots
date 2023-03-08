#!/usr/bin/env zsh
set -ex

# Install oh-my-zsh if not present
if test -z "${ZSH}" || test ! -d "${ZSH}"; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Make Homebrew's zsh the default shell
chsh -s /usr/local/bin/zsh
