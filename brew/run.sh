#!/usr/bin/env bash
set -e
BASE_DIR=$(dirname "$(readlink -f "$0")")
BREW_FILE="$(dirname "$0")/$1"

if [[ $(sysctl -n machdep.cpu.brand_string) == *"Intel"* ]]; then
    # Only run the main Brewfile on Intel
    "${BASE_DIR}/run-brew.sh" "${BASE_DIR}/Brewfile"
else 
    # Run the main Brewfile and the Rosetta Brewfile on Apple Silicon
    arch -arm64 "${BASE_DIR}/run-brew.sh" "${BASE_DIR}/Brewfile"
    arch -x86_64 "${BASE_DIR}/run-brew.sh" "${BASE_DIR}/Brewfile_Rosetta"
fi
