#!/bin/bash
# METASYSTEM_SCC Legal System - md-picture-license-time-precommit-update
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
# Version: 2025.0.0.2
# License: Proprietary
# Author: Róbert Kovács (ncoldwave)
#
# Description: Update date and time in md file license - with pre-commit hook merge
# Usage: ./md-picture-license-time-precommit-update.sh
#
# Dependencies: [List any required tools/software]
#
# Security Notice: This script contains proprietary automation procedures.
#                 Do not share or modify without explicit authorization.
#
# Legal Notice: For legal compliance and audit purposes, all executions
#              of this script are logged and monitored.

HOOK_FILE=".git/hooks/pre-commit"
HOOK_MARKER="# === HOOK: MARKDOWN TIMESTAMP UPDATER ==="

echo "🔧 Installing or updating markdown timestamp pre-commit hook..."

# If the marker is already there, we don't add it again, but we don't exit either.
if grep -qF "$HOOK_MARKER" "$HOOK_FILE" 2>/dev/null; then
    echo "✅ Markdown timestamp hook already present. No changes made."
else
    #If the hook file does not exist, create it with shebang
    if [ ! -f "$HOOK_FILE" ]; then
        echo "#!/bin/bash" > "$HOOK_FILE"
        echo "" >> "$HOOK_FILE"
    else
        # Backup
        cp "$HOOK_FILE" "$HOOK_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        echo "🗂 Backup created: $HOOK_FILE.backup.*"

        # If there is no shebang, we insert it at the beginning
        if ! grep -q "^#!/bin/bash" "$HOOK_FILE"; then
            sed -i '1i #!/bin/bash\n' "$HOOK_FILE"
        fi
    fi

    # Add the hook logic
    cat >> "$HOOK_FILE" << 'EOF'

# === HOOK: MARKDOWN TIMESTAMP UPDATER ===

NOW_UTC=$(date -u +"%B %d, %Y, %H:%M UTC")
HAS_MD=$(git diff --cached --name-only --diff-filter=ACM | grep '\.md$' || true)

if [ -n "$HAS_MD" ]; then
  echo "📝 Updating timestamps in staged .md files..."

  echo "$HAS_MD" | while read -r file; do
    [ -f "$file" ] || continue

    sed -i.bak \
      -e "s|^\*\*Effective:\*\* .*|**Effective:** $NOW_UTC  |" \
      -e "s|^\*Last Updated: .*|*Last Updated: $NOW_UTC*  |" \
      "$file"

    git add "$file"
    rm -f "$file.bak"
  done
else
  echo "⏩ No .md files staged — skipping markdown timestamp logic."
fi
EOF

    echo "✅ Markdown timestamp hook logic added."
fi

# Make it executable
chmod +x "$HOOK_FILE"
