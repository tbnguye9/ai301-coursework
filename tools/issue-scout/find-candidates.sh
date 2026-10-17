#!/usr/bin/env bash
# Usage: bash ~/find-candidates.sh python   (or javascript)
LANG_ARG="$1"
MAX_REPO_CREATED="2026-07-19"   # repo must be at least 90 days old
MIN_PUSHED="2026-09-17"         # repo must have a push in the last 30 days
declare -A REPO_INFO
gh search issues --language "$LANG_ARG" --label "good first issue" --state open --archived=false --no-assignee --comments 0 --created "2026-07-01..2026-09-25" --limit 80 --json url,title,repository,createdAt --jq '.[] | "\(.repository.nameWithOwner)\t\(.url)\t\(.createdAt[:10])\t\(.title[:80])"' |
while IFS=$'\t' read -r repo url created title; do
  n=${url##*/}
  if [ -z "${REPO_INFO[$repo]}" ]; then
    REPO_INFO[$repo]=$(gh api "repos/$repo" --jq '"\(.created_at[:10]) \(.pushed_at[:10]) \(.stargazers_count)"' 2>/dev/null)
  fi
  read -r rcreated rpushed stars <<< "${REPO_INFO[$repo]}"
  [ -z "$rcreated" ] && continue
  [[ "$rcreated" > "$MAX_REPO_CREATED" ]] && continue
  [[ "$rpushed" < "$MIN_PUSHED" ]] && continue
  prs=$(gh api "repos/$repo/issues/$n/timeline" --paginate --jq '.[] | select(.event=="cross-referenced") | select(.source.issue.pull_request != null) | select(.source.issue.state=="open") | .source.issue.number' 2>/dev/null | wc -l | tr -d ' ')
  [ "$prs" -gt 0 ] && continue
  echo "$repo | stars=$stars | issue created $created | $url | $title"
done
