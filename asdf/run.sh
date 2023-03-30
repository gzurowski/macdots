#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")

# Set up asdf
# shellcheck disable=SC1091
source "${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh"

# Install plugins
while read -r plugin; do
    echo "Installing plugin '${plugin}'..."
    # Don't error out when plugins are already installed.
    # See https://github.com/asdf-vm/asdf/issues/841.
    sh -c "asdf plugin-add ${plugin}" || true
done < "${BASEDIR}/plugins.txt"

# Install JDKs
while read -r version; do
    echo "Installing java ${version}..."
    asdf install java "${version}"
done < "${BASEDIR}/java.txt"

# Uninstall JDKs not in java.txt
while read -r version; do
    version="${version/#\*/}"
    echo "Uninstalling Java ${version}..."
    asdf uninstall java "${version}"
done < <(asdf list java | grep -v -f "${BASEDIR}/java.txt" -)
