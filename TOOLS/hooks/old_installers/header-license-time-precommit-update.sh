#!/bin/bash

# METASYSTEM_SCC Legal System - header-license-time-precommit-Update
#
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
# Current User's Login: ncoldwave
#
#  Copyright (c) Róbert Kovács. All rights reserved.
#  Proprietary and confidential.
#
#  This script is licensed for use exclusively by AeternValens™ until revoked.
#  Unauthorized use, copying, modification, or distribution is strictly prohibited.
#  License remains valid until explicitly revoked by the copyright holder.
#
#  Contact:        legal@aeternvalens.com, robbi.mobile@gmail.com
#  Repository: https://github.com/ncoldwave/Design-Media
#
#
# Version: 2025.0.0.2
# License: Proprietary
# Author: Róbert Kovács (ncoldwave)
#
# Description: Update header file license with date and time - with pre-commit hook merge mechanism
# Usage: ./header-license-time-precommit-Update.sh
#
# Dependencies: [List any required tools/software]
#
# Security Notice: This script contains proprietary automation procedures.
#                 Do not share or modify without explicit authorization.
#
# Legal Notice: For legal compliance and audit purposes, all executions
#              of this script are logged and monitored.

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
    cat >> "$HOOK_FILE" << EOF_SCRIPT

# Simple Universal Pre-commit hook - METASYSTEM_SCC Legal System
export LANG=en_US.UTF-8
export LC_ALL=C.UTF-8
export LC_CTYPE=UTF-8

CURRENT_UTC=\$(date -u '+%Y-%m-%d %H:%M:%S')
CURRENT_USER=\$(git config user.name || whoami)

echo "🔄 Simple universal hook active!"
echo "📅 UTC: \$CURRENT_UTC"
echo "👤 User: \$CURRENT_USER"

STAGED_FILES=\$(git diff --cached --name-only --diff-filter=ACM)

if [ -z "\$STAGED_FILES" ]; then
    echo "ℹ️  No staged files."
else
    echo "📁 Staged files: \$(echo "\$STAGED_FILES" | wc -l) files"
    MODIFIED_COUNT=0

    echo "\$STAGED_FILES" | while IFS= read -r file; do
        if [ -f "\$file" ]; then
            if grep -q "Current Date and Time (UTC.*formatted):\\|Current User's Login:" "\$file" 2>/dev/null; then
                echo "📝 Found metadata in: \$file"
                cp "\$file" "\$file.bak"

                sed -i "s/\(.*\)Current Date and Time (UTC[^)]*formatted): .*/\1Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
                LC_ALL=C.UTF-8 sed -i '' -E "s#(.*Current Date and Time \(UTC[^\)]*formatted\): ).*#\1$CURRENT_UTC#" "$file"

                if ! cmp -s "\$file" "\$file.bak"; then
                    git add "\$file"
                    echo "✅ Updated: \$file"
                    MODIFIED_COUNT=\$((MODIFIED_COUNT + 1))
                else
                    echo "ℹ️  No changes: \$file"
                fi

                rm -f "\$file.bak"
            fi
        fi
    done

    echo "🎉 Hook completed! \$MODIFIED_COUNT files updated."
fi
EOF_SCRIPT

    echo "✅ Simple universal hook logic added."
fi


# Végrehajthatóvá tesszük
chmod +x "$HOOK_FILE"

echo "🎯 Now works with ANY comment style:"
echo "   # Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   // Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   /* Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   <!-- Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   * Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   ; Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
echo "   Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
