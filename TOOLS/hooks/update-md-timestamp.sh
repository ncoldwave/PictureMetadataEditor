#!/bin/bash
# update-md-timestamp.sh - Markdown timestamp updater Script
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
#
# Version: 2025.0.0.1-Preview
# License: Proprietary
# Author: Róbert Kovács (ncoldwave)
# Created: 2025-07-05 06:36:00 UTC
#
# Description: Updates effective and last updated timestamps in staged .md files.
# Usage: ./install-hooks.sh
#
# Dependencies: cat, mv, grep, bash, git
#
# Security Notice: This script contains proprietary automation procedures.
#                 Do not share or modify without explicit authorization.
#
# Legal Notice: For legal compliance and audit purposes, all executions
#              of this script are logged and monitored.

set -e

NOW_UTC=$(date -u +"%B %d, %Y, %H:%M UTC")
MODIFIED=0
HOOK_DIR="TOOLS/hooks"

# Skip Git internal hooks
if [[ "$file" == ".git/hooks/"* || "$file" == "TOOLS/hooks/"* ]]; then
  echo "⏩ Skipping internal hook file: $file"
  continue
fi

echo "🔄 Updating markdown timestamps..."

git diff --cached --name-only --diff-filter=ACM | grep '\.md$' | while IFS= read -r file; do
  [ -f "$file" ] || continue

  if [[ "$file" == "$HOOK_DIR/"* ]]; then
    echo "⏩ Skipping hook script: $file"
    continue
  fi

  echo "📝 Updating: $file"
  rm -f "$file.bak"
  cp "$file" "$file.bak"

  sed -i \
    -e "s|^\*\*Effective:\*\* .*|**Effective:** $NOW_UTC  |" \
    -e "s|^\*Last Updated: .*|*Last Updated: $NOW_UTC*  |" \
    "$file"

  if ! cmp -s "$file" "$file.bak"; then
    git add -- "$file"
    MODIFIED=$((MODIFIED + 1))
  fi

  rm -f "$file.bak"
done

echo "✅ Markdown timestamp update complete. Modified: $MODIFIED"
exit 0
