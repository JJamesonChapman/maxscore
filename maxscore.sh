#!/usr/bin/env bash
# maxscore.sh
# Jake Jameson
# CPSC 298

set -euo pipefail

scores=()
max=""

echo "Enter 5 scores:"

i=0
while (( i < 5 )); do
  # Read one line
  if ! IFS= read -r line; then
    echo "Error: expected 5 scores, but input ended early." >&2
    exit 1
  fi

  # Trim whitespace
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"

  # Validate positive integer
  if [[ ! "$line" =~ ^[1-9][0-9]*$ ]]; then
    echo "Invalid input: '$line' (please enter a positive integer)" >&2
    continue
  fi

  scores[i]="$line"

  if (( i == 0 )); then
    max="$line"
  else
    if (( line > max )); then
      max="$line"
    fi
  fi

  (( i++ ))
done

echo "The highest score is $max"
echo "The scores are:"

for s in "${scores[@]}"; do
  diff=$(( max - s ))
  echo "$s differs from max by $diff"
done
