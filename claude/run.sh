#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")
REPO_ROOT=$(cd "${BASEDIR}/.." && pwd)

mkdir -p "${HOME}/.claude"

ln -sfv "${REPO_ROOT}/agents/AGENTS.md" "${HOME}/.claude/CLAUDE.md"

# Skills directory and symlinks
mkdir -p "${HOME}/.claude/skills"

for skill in "${REPO_ROOT}"/agents/skills/*/; do
    ln -sfnv "${skill%/}" "${HOME}/.claude/skills/$(basename "${skill}")"
done
