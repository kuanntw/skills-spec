#!/usr/bin/env bash
set -euo pipefail

test -f SKILL.md
test -f skill.json
test -d references
test -d scripts
test -d assets
test -d evals
printf 'full-skill package layout is valid\n'
