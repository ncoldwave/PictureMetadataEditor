#!/bin/bash
# METASYSTEM_SCC Legal System - header-license-time-precommit-Update
#
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
# Current User's Login: ncoldwave
#
# Description: Update header file license with date and time - with pre-commit hook merge mechanism
# Usage: ./header-license-time-precommit-Update.sh

HOOK_FILE=".git/hooks/pre-commit"
HOOK_MARKER="# Simple Universal Pre-commit hook - METASYSTEM_SCC Legal System"

echo "🔧 Installing or updating universal pre-commit hook..."

if grep -qF "$HOOK_MARKER" "$HOOK_FILE" 2>/dev/null; then
    echo "✅ Hook already contains the universal logic. No changes made."
else
    # Biztonsági mentés
    if [ -f "$HOOK_FILE" ]; then
        cp "$HOOK_FILE" "$HOOK_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        echo "🗂 Backup created: $HOOK_FILE.backup.*"
    else
        touch "$HOOK_FILE"
    fi

    # Ha nem létezik a hook fájl, létrehozzuk shebang-gel
    if ! grep -q "^#!/bin/bash" "$HOOK_FILE"; then
        sed -i '1i #!/bin/bash\n' "$HOOK_FILE"
    fi

    # Hozzáfűzzük a hook logikát
    cat >> "$HOOK_FILE" << 'EOF'

# Simple Universal Pre-commit hook - METASYSTEM_SCC Legal System
# Searches ANY line containing the special patterns, regardless of comment style

export LC_ALL=C.UTF-8

CURRENT_UTC=$(date -u '+%Y-%m-%d %H:%M:%S')
CURRENT_USER=$(git config user.name || echo "$(whoami)")

echo "🔄 Simple universal hook active!"
echo "📅 UTC: $CURRENT_UTC"
echo "👤 User: $CURRENT_USER"

STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM)

if [ -z "$STAGED_FILES" ]; then
    echo "ℹ️  No staged files."
else
    echo "📁 Staged files: $(echo "$STAGED_FILES" | wc -l) files"
    MODIFIED_COUNT=0

    for file in $STAGED_FILES; do
        if [ -f "$file" ]; then
            if grep -q "Current Date and Time (UTC.*formatted):\|Current User's Login:" "$file" 2>/dev/null; then
                echo "📝 Found metadata in: $file"
                cp "$file" "$file.bak"

                # Replace timestamp pattern ANYWHERE in the line (preserving everything else)
                sed -i "s/\(.*\)Current Date and Time (UTC[^)]*formatted): .*/\1Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31

                # Replace user pattern ANYWHERE in the line (preserving everything else)
                sed -i "s/\(.*\)Current User's Login: .*/\1Current User's Login: ncoldwave



                if ! cmp -s "$file" "$file.bak"; then
                    git add "$file"
                    echo "✅ Updated: $file"
                    MODIFIED_COUNT=$((MODIFIED_COUNT + 1))
                else
                    echo "ℹ️  No changes: $file"
                fi

                rm -f "$file.bak"
            fi
        fi
    done

    echo "🎉 Hook completed! $MODIFIED_COUNT files updated."
fi
EOF

    echo "✅ Simple universal hook logic added."
fi


# Végrehajthatóvá tesszük
chmod +x "$HOOK_FILE"

echo "🎯 Now works with ANY comment style:"
echo "   # Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
echo "   // Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
echo "   /* Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
echo "   <!-- Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
echo "   * Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
echo "   ; Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
echo "   Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-09-10 19:54:31
