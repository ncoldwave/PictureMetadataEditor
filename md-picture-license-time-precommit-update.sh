#!/bin/bash
# METASYSTEM_SCC Legal System - md-picture-license-time-precommit-update
#
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-01 23:05:04
# Current User's Login: ncoldwave
#
# Description: Update date and time in md file license - with pre-commit hook merge
# Usage: ./md-picture-license-time-precommit-update.sh

HOOK_FILE=".git/hooks/pre-commit"
HOOK_MARKER="# === HOOK: MARKDOWN TIMESTAMP UPDATER ==="

echo "🔧 Installing or updating markdown timestamp pre-commit hook..."

# Ha már benne van a marker, nem fűzzük hozzá újra, de nem lépünk ki
if grep -qF "$HOOK_MARKER" "$HOOK_FILE" 2>/dev/null; then
    echo "✅ Markdown timestamp hook already present. No changes made."
else
    # Ha nem létezik a hook fájl, létrehozzuk shebang-gel
    if [ ! -f "$HOOK_FILE" ]; then
        echo "#!/bin/bash" > "$HOOK_FILE"
        echo "" >> "$HOOK_FILE"
    else
        # Biztonsági mentés
        cp "$HOOK_FILE" "$HOOK_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        echo "🗂 Backup created: $HOOK_FILE.backup.*"

        # Ha nincs benne shebang, beszúrjuk az elejére
        if ! grep -q "^#!/bin/bash" "$HOOK_FILE"; then
            sed -i '1i #!/bin/bash\n' "$HOOK_FILE"
        fi
    fi

    # Hozzáfűzzük a hook logikát
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

# Futtathatóvá tesszük
chmod +x "$HOOK_FILE"
