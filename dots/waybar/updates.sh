#!/bin/sh
# Display pending repo and AUR updates for Waybar and hide the module when
# the combined total is below the configured threshold.

threshold=25
repo_count=0
aur_count=0

if command -v checkupdates >/dev/null 2>&1; then
  repo_count=$(checkupdates 2>/dev/null | wc -l | tr -d ' ')
fi

if command -v paru >/dev/null 2>&1; then
  aur_count=$(paru -Qua 2>/dev/null | wc -l | tr -d ' ')
fi

total=$((repo_count + aur_count))

if [ "$total" -lt "$threshold" ]; then
  printf ""
  exit 0
fi

printf " %s | AUR %s\n" "$repo_count" "$aur_count"
