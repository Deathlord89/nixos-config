#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check we're inside a git repo
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo -e "${RED}❌ Not a git repository.${NC}"
  exit 1
fi

# Ensure required tools are available
for cmd in jq nix diff; do
  if ! command -v "$cmd" &>/dev/null; then
    echo -e "${RED}❌ Missing required command: $cmd${NC}"
    exit 1
  fi
done

# Backup current lock
cp flake.lock flake.lock.bak

echo -e "${GREEN}▶ Running: nix flake update...${NC}"
nix flake update

echo -e "${GREEN}✔ Update complete. Comparing flake.lock...${NC}"

# Extract changes from flake.lock using jq
changes=""
for input in $(jq -r '.nodes | to_entries[] | select(.value.locked.rev) | .key' flake.lock); do
  old_rev=$(jq -r --arg input "$input" '.nodes[$input].locked.rev' flake.lock.bak 2>/dev/null || echo "")
  new_rev=$(jq -r --arg input "$input" '.nodes[$input].locked.rev' flake.lock 2>/dev/null || echo "")

  if [[ -n "$old_rev" && -n "$new_rev" && "$old_rev" != "$new_rev" ]]; then
    changes+=$'\n'"- $input: ${old_rev:0:7} → ${new_rev:0:7}"
  fi
done

# Clean up
rm flake.lock.bak

# Commit if any changes found
if [ -n "$changes" ]; then
  git add flake.lock
  git commit -m "chore(flake): update inputs

Updated flake inputs:$changes"
  echo -e "${GREEN}✔ flake.lock committed.${NC}"
else
  echo -e "${RED}⚠ No input revision changes detected. Nothing to commit.${NC}"
fi
