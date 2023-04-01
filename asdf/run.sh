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

# Remove plugins not in plugins.txt
while read -r plugin; do
    echo "Uninstalling plugin '${plugin}'..."
    asdf plugin-remove "${plugin}"
done < <(comm -23 <(asdf plugin-list) <(cat "${BASEDIR}/plugins.txt"))

# Install JDKs
while read -r version alias; do
    echo "Installing java ${version}..."
    asdf install java "${version}"
    echo "Setting alias ${alias} for java ${version}..."
    [ -n "$alias" ] && asdf alias java "${alias}" "${version}"
done < "${BASEDIR}/java.txt"

# Uninstall JDKs not in java.txt
# Take a list of installed JDKs and remove all aliases.
installed=$(comm -23 \
    <(asdf list java | tr -d ' ' | sed 's/^\*//') \
    <(asdf alias java --list | awk '{print $1}' ) | \
    sort) 
selected=$(awk '{print $1}' < "${BASEDIR}/java.txt" | sort)

while read -r version; do
    echo "Uninstalling java ${version}..."
    asdf uninstall java "${version}"
done < <(comm -23 <(echo "$installed") <(echo "$selected"))
