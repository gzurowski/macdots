#!/usr/bin/env bash
set -e
PINENTRY_CONFIG="pinentry-program $(brew --prefix)/bin/pinentry-mac"

mkdir -p "${HOME}/.gnupg"
chmod 700 "${HOME}/.gnupg"

# Add pinentry-mac to gpg-agent.conf
if ! test -f "${HOME}/.gnupg/gpg-agent.conf" || ! grep -q "${PINENTRY_CONFIG}" "${HOME}/.gnupg/gpg-agent.conf"; then
    echo "Configuring pinentry-mac..."
    echo "${PINENTRY_CONFIG}" | sudo tee -a "${HOME}/.gnupg/gpg-agent.conf"
fi
