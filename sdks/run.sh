#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")
SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec

source "${SDKMAN_DIR}/bin/sdkman-init.sh"

function removeJenvAliases() {
    java_version="$1"
    jdk_path="$(realpath "$(sdk home java $java_version)")"
    echo "Removing aliases for path ${jdk_path}"
    while read -r jenv_alias; do
        echo "alias ${jenv_alias}"
        jenv remove "$jenv_alias"
    done < <(jenv versions --verbose | \
        awk -v pat="$jdk_path" 'match($0, pat) {print a}{a=b;b=$0}' | \
        tr -d '[:blank:]')
}

# Install JDKs with SDKMAN
while read -r VERSION || [ -n "$VERSION" ]; do
    echo "Installing Java ${VERSION}..."
    yes n | sdk install java $VERSION
    jenv add "$(sdk home java $VERSION)"
done < "${BASEDIR}/jdks.txt"

# Remove JDKs that are not in sdks.txt
while read -r java_version; do
    echo "Removing Java ${java_version}..."
    removeJenvAliases "$java_version"
    sdk uninstall java "$java_version"
done < <(sdk list java | grep "installed" | \       # get all installed JDKs with SDKMAN
    tr -d '[:blank:]' | awk -F '|' '{print $6}' | \ # get the identifier from the 6th column
    grep -v -f "${BASEDIR}"/jdks.txt -)             # remove the ones that are in jdks.txt
