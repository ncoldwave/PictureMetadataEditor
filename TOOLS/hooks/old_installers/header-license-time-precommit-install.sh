#!/bin/bash
# METASYSTEM_SCC Legal System - header-license-time-precommit-install
#
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
# Current User's Login: ncoldwave
#
# Description: Update header file license with date and time
# Usage: ./header-license-time-precommit-install.sh

echo "🔧 Creating simple universal hook - searches ANY line!"

# Backup current hook
cp .git/hooks/pre-commit .git/hooks/pre-commit.backup.$(date +%Y%m%d_%H%M%S)

# Create simple universal hook
cat > ".git/hooks/pre-commit" << 'EOF'
#!/bin/bash

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
    exit 0
fi

echo "📁 Staged files: $(echo "$STAGED_FILES" | wc -l) files"

MODIFIED_COUNT=0

for file in $STAGED_FILES; do
    if [ -f "$file" ]; then
        # Check if file contains the special patterns anywhere in any line
        if grep -q "Current Date and Time (UTC.*formatted):\|Current User's Login:" "$file" 2>/dev/null; then
            echo "📝 Found metadata in: $file"
            
            # Create backup
            cp "$file" "$file.bak"
            
            # Replace timestamp pattern ANYWHERE in the line (preserving everything else)
            sed -i 's/\(.*\)Current Date and Time (UTC[^)]*formatted): [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]\(.*\)/\1Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
            
            # Replace user pattern ANYWHERE in the line (preserving everything else)
            sed -i 's/\(.*\)Current User'\''s Login: [^$]*/\1Current User'\''s Login: '"$CURRENT_USER"'/' "$file"
            
            # Check if file actually changed
            if ! cmp -s "$file" "$file.bak"; then
                git add "$file"
                echo "✅ Updated: $file"
                MODIFIED_COUNT=$((MODIFIED_COUNT + 1))
            else
                echo "ℹ️  No changes: $file"
            fi
            
            # Clean up backup
            rm -f "$file.bak"
        fi
    fi
done

echo "🎉 Hook completed! $MODIFIED_COUNT files updated."
exit 0
EOF

chmod +x ".git/hooks/pre-commit"

echo "✅ Simple universal hook installed!"
echo ""
echo "🎯 Now works with ANY comment style:"
echo "   # Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   // Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   /* Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   <!-- Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   * Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   ; Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo ""
echo "🔍 Hook searches EVERY line in EVERY file for the pattern!"
