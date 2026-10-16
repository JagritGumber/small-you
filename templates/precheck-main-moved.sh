#!/usr/bin/env bash
# Precheck for automations that react to merged code, such as a docs check:
# start only when origin/main has moved since the last run started.
# Exit 0 starts the agent; anything else skips the run without a model.
# Needs a remote called origin with a main branch.
#
# It records the commit when it says yes, so a run that fails still counts
# as seen. Delete state/last-main.txt to force the next run.
set -u
cd "$(dirname "$0")" || exit 2
state="state/last-main.txt"
git fetch --quiet origin main || exit 2
now="$(git rev-parse origin/main)" || exit 2
[ "$(cat "$state" 2>/dev/null)" = "$now" ] && exit 1
mkdir -p state && printf '%s\n' "$now" > "$state"
exit 0
