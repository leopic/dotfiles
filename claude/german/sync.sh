#!/bin/bash
set -e

STATE="$HOME/.claude/german/state.json"
TMP="/tmp/german_state_tmp.json"
DOTFILES="$HOME/dotfiles"

jq --argjson ts "$(date +%s)" '.last_session_timestamp = $ts' "$STATE" > "$TMP" && mv "$TMP" "$STATE"

cd "$DOTFILES"
git add claude/german/state.json
git diff --cached --quiet || git commit -m "chore(german): sync b1 progress"
git push
