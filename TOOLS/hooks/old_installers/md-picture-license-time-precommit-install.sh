#!/bin/bash
# METASYSTEM_SCC Legal System - md-picture-license-time-precommit-install
#
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
# Current User's Login: ncoldwave
#
# Description: Update date and time in md file license
# Usage: ./md-picture-license-time-precommit-install.sh

HOOK_FILE=".git/hooks/pre-commit"

cat > "$HOOK_FILE" << 'EOF'
#!/bin/bash

# === HOOK: MARKDOWN TIMESTAMP UPDATER ===

NOW_UTC=$(date -u +"%B %d, %Y, %H:%M UTC")

git diff --cached --name-only --diff-filter=ACM | grep '\.md$' | while read -r file; do
  [ -f "$file" ] || continue

  sed -i.bak \
    -e "s|^\*\*Effective:\*\* .*|**Effective:** $NOW_UTC  |" \
    -e "s|^\*Last Updated: .*|*Last Updated: $NOW_UTC*  |" \
    "$file"

  git add "$file"
  rm -f "$file.bak"
done
EOF

# 🔐 This line makes the hook executable
chmod +x "$HOOK_FILE"

echo "✅ pre-commit hook installed and made executable."
