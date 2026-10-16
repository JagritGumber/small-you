#!/usr/bin/env bash
# Precheck for a PR review automation: start only when an open pull request
# someone else wrote has a commit the review hasn't seen yet.
# Exit 0 starts the agent; anything else skips the run without a model.
# Needs the GitHub CLI (gh), logged in.
#
# The review playbook appends "<number> <head sha>" to .small-you/state/pr-review-heads.txt
# for each pull request it reviews, so the same commit is never reviewed twice.
set -u
cd "$(dirname "$0")" || exit 2
reviewed="state/pr-review-heads.txt"
me="$(gh api user --jq .login)" || exit 2
open="$(ME="$me" gh pr list --state open --json number,headRefOid,author \
  --jq '.[] | select(.author.login != env.ME) | "\(.number) \(.headRefOid)"')" || exit 2
while read -r line; do
  [ -n "$line" ] || continue
  grep -qxF "$line" "$reviewed" 2>/dev/null || exit 0
done <<< "$open"
exit 1
