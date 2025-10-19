#!/bin/bash

echo "🔧 Updating hook to support additional file types..."

# Backup current hook
cp .git/hooks/pre-commit .git/hooks/pre-commit.backup

# Update the file extension pattern in the hook
sed -i 's/grep -E '\''\\.(md|txt|yml|yaml|json|php|sh|py)\\$/grep -E '\''\\.(md|txt|yml|yaml|json|php|sh|py|tf|hcl|jsx|tsx|js|ts|ansible)\\$/' .git/hooks/pre-commit

echo "✅ Hook updated to support:"
echo "   - Terraform (.tf, .hcl)"
echo "   - Ansible (.yml, .ansible)"  
echo "   - React (.jsx, .tsx)"
echo "   - JavaScript/TypeScript (.js, .ts)"

echo ""
echo "📋 Full supported file types:"
grep "grep -E" .git/hooks/pre-commit | head -1