#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")
REPO_ROOT=$(cd "${BASEDIR}/.." && pwd)

mkdir -p "${HOME}/.codex"

ln -sfv "${REPO_ROOT}/agents/AGENTS.md" "${HOME}/.codex/AGENTS.md"

# Skills directory and symlinks
mkdir -p "${HOME}/.codex/skills"

for skill in "${REPO_ROOT}"/agents/skills/*/; do
    ln -sfnv "${skill%/}" "${HOME}/.codex/skills/$(basename "${skill}")"
done
