#!/bin/bash

# update-sh-header.sh - Metadata updater for all staged files except .md
#
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
# Current User's Login: ncoldwave
#
#  Copyright (c) Róbert Kovács. All rights reserved.
#  Proprietary and confidential.
#
#  This script is licensed for use exclusively by UniVital.Net until revoked.
#  Unauthorized use, copying, modification, or distribution is strictly prohibited.
#  License remains valid until explicitly revoked by the copyright holder.
#
#  Contact:        legal@univital.net, robbi.mobile@gmail.com
#  Repository: https://github.com/ncoldwave/Design-Media
#
# Project: METASYSTEM_SCC™ Legal System
# Component: Deployment Automation
# Version: 2025.0.0.1-Preview
# License: Proprietary
# Author: Róbert Kovács (ncoldwave)
# Created: 2025-07-05 06:36:00 UTC
#
# Description: Updates metadata headers in staged files before commit.
#              JSON files are updated using sed with syntax preservation.
# Usage: ./update-sh-header.sh
#
# Dependencies: git, sed, bash
#
# Security Notice: This script contains proprietary automation procedures.
#                 Do not share or modify without explicit authorization.
#
# Legal Notice: For legal compliance and audit purposes, all executions
#              of this script are logged and monitored.

set -e

SCRIPT_PATH=$(realpath "$0")
CURRENT_UTC=$(date -u '+%Y-%m-%d %H:%M:%S')
CURRENT_USER=$(git config user.name || whoami)
VERSION="2025.0.0.1-Preview"
AUTHOR="Róbert Kovács (ncoldwave)"
MODIFIED=0

echo "🔄 Updating metadata headers..."

git diff --cached --name-only --diff-filter=ACM | while IFS= read -r file; do
  [ -f "$file" ] || continue

  # Skip internal hook files
  if [[ "$file" == ".git/hooks/"* || "$file" == "TOOLS/hooks/"* ]]; then
    echo "⏩ Skipping internal hook file: $file"
    continue
  fi

  # Skip markdown files
  if [[ "$file" == *.md ]]; then
    echo "⏩ Skipping markdown file: $file"
    continue
  fi

  # Skip this script itself
  if [[ "$(realpath "$file")" == "$SCRIPT_PATH" ]]; then
    echo "⏩ Skipping self: $file"
    continue
  fi

  # ✅ Quickly update JSON files with sed
  if [[ "$file" == *.json ]]; then
    echo "📝 Updating JSON metadata (sed): $file"

    for key in "_timestamp" "_user" "_version" "_author"; do
      value=""
      case "$key" in
        "_timestamp") value="$CURRENT_UTC" ;;
        "_user") value="$CURRENT_USER" ;;
        "_version") value="$VERSION" ;;
        "_author") value="$AUTHOR" ;;
      esac

      # Update the line while preserving end-of-line characters
      sed -i -E "s#(\"$key\":\s*\").*?(\",?\}?,?)\$#\1$value\2#" "$file"
    done

    if ! git diff --quiet -- "$file"; then
      git add "$file"
      MODIFIED=$((MODIFIED + 1))
    fi

    continue
  fi

  # ✅ Update all other files by header
  if grep -q "Current Date and Time (UTC.*formatted):\|Current User's Login:" "$file"; then
    echo "📝 Updating metadata in: $file"

    rm -f "$file.bak"
    cp "$file" "$file.bak"

    # Updates all other files based on the header, leaving the beginning and end of the line unchanged.
    sed -i -E "s|(Current Date and Time \(UTC - YYYY-MM-DD HH:MM:SS formatted\):)[^\"]*|\1 $CURRENT_UTC|" "$file"

    # Updates the user value, leaving the beginning and end of the line unchanged
    sed -i -E "s|(Current User's Login:)[^\"]*|\1 $CURRENT_USER|" "$file"



    if ! cmp -s "$file" "$file.bak"; then
      git add -- "$file"
      MODIFIED=$((MODIFIED + 1))
    fi

    rm -f "$file.bak"
  fi
done

echo "✅ Metadata update complete. Modified: $MODIFIED"
exit 0
