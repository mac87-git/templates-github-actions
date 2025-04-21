#!/usr/bin/env bash

set -e

CURRENT_METADATA="$1"
EXTRA_REPOS_METADATA="$2"
DUPLICATES_DIR="$3"

mkdir -p "$DUPLICATES_DIR"

CURRENT_PATHS_FILE="${CURRENT_METADATA}.path"
cut -d, -f1 "$CURRENT_METADATA" | sort > "$CURRENT_PATHS_FILE"

found_duplicates=false
current_base_name=$(basename "$CURRENT_METADATA")

echo "🔍 Checking for duplicates against other CSVs in $EXTRA_REPOS_METADATA..."

for file in "$EXTRA_REPOS_METADATA"/*.csv; do
  base_name=$(basename "$file")
  if [ "$base_name" != "$current_base_name" ]; then
    echo "🔍 Comparing with $base_name"
    TEMP_PATHS="${base_name}.paths"
    cut -d, -f1 "$file" | sort > "$TEMP_PATHS"
    comm -12 "$CURRENT_PATHS_FILE" "$TEMP_PATHS" > "$DUPLICATES_DIR/$base_name.duplicates"

    if [ -s "$DUPLICATES_DIR/$base_name.duplicates" ]; then
      echo "❌ Duplicates found in $base_name:"
      cat "$DUPLICATES_DIR/$base_name.duplicates"
      found_duplicates=true
    fi

    rm -f "$TEMP_PATHS"
  fi
done

if $found_duplicates; then
  echo "🚫 Duplicate paths detected. Failing the action."
  exit 1
else
  echo "✅ No duplicate paths found."
fi
