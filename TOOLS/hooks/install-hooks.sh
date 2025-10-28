#!/bin/bash
# install-hooks.sh - Append-only pre-commit hook installer
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
# Version: 2025.0.0.1-Preview
# License: Proprietary
# Author: Róbert Kovács (ncoldwave)
# Created: 2025-07-05 06:36:00 UTC
#
# Description: Append-only pre-commit hook installer
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

GIT_ROOT=$(git rev-parse --show-toplevel)
HOOK_FILE="$GIT_ROOT/.git/hooks/pre-commit"
CONFIG_FILE=".hook-config"

echo "🔧 Installing pre-commit hook..."

# Create hook file if it doesn't exist
if [ ! -f "$HOOK_FILE" ]; then
  echo "📄 Creating new pre-commit hook file."
  echo "#!/bin/bash" > "$HOOK_FILE"
fi

# Ensure shebang is present at the top
first_line=$(head -n 1 "$HOOK_FILE")
if [[ "$first_line" != "#!"* ]]; then
  echo "⚠️  Missing shebang. Prepending '#!/bin/bash' to hook."
  tmpfile=$(mktemp)
  echo "#!/bin/bash" > "$tmpfile"
  cat "$HOOK_FILE" >> "$tmpfile"
  mv "$tmpfile" "$HOOK_FILE"
fi

# Append logic for each script in .hook-config
while IFS= read -r script; do
  [[ "$script" =~ ^#.*$ || -z "$script" ]] && continue

  if grep -Fq "$script" "$HOOK_FILE"; then
    echo "✅ Script already handled in hook: $script"
  else
    echo "➕ Appending hook logic for: $script"
# Generate safe variable name
varname=$(basename "$script" | tr -c 'a-zA-Z0-9' '_' | tr '[:upper:]' '[:lower:]')
varname="SCRIPT_${varname}"

cat >> "$HOOK_FILE" <<EOF

# Hook for: $script
$varname="\$(dirname "\$0")/../../$script"

if [ -x "\$$varname" ]; then
  echo "▶️  Executing: \$$varname"
  bash "\$$varname" || exit \$?
else
  echo "⚠️  Skipping non-executable or missing script: \$$varname"
fi
EOF
  fi
done < "$CONFIG_FILE"

chmod +x "$HOOK_FILE"
echo "✅ Pre-commit hook updated and executable."
