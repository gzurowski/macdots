#!/usr/bin/env bash
set -e
BASEDIR=$(dirname "$(readlink -f "$0")")
REPO_ROOT=$(cd "${BASEDIR}/.." && pwd)

mkdir -p "${HOME}/.claude"

ln -sfv "${REPO_ROOT}/agents/AGENTS.md" "${HOME}/.claude/CLAUDE.md"
