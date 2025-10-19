#!/bin/bash

echo "🧪 Testing universal pattern matching..."

# Test different comment styles
cat > "test1.sh" << 'EOF'
#!/bin/bash
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-06-24 22:43:56
# Current User's Login: Ncoldwave
echo "test"
EOF

cat > "test2.js" << 'EOF'
// Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-06-24 22:43:56
// Current User's Login: Ncoldwave
console.log("test");
EOF

cat > "test3.css" << 'EOF'
/* Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-06-24 22:43:56 */
/* Current User's Login: Ncoldwave
.test { color: red; }
EOF

cat > "test4.html" << 'EOF'
<!-- Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-06-24 22:43:56 -->
<!-- Current User's Login: Ncoldwave
<h1>Test</h1>
EOF

cat > "test5.sql" << 'EOF'
-- Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-06-24 22:43:56
-- Current User's Login: Ncoldwave
SELECT * FROM test;
EOF

cat > "test6.asm" << 'EOF'
; Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-06-24 22:43:56
; Current User's Login: Ncoldwave
MOV AX, BX
EOF

echo "📄 Created test files with different comment styles"
echo ""

echo "📋 Before (all should show 2020-01-01):"
grep "Current Date and Time\|Current User's Login" test*.* || true

echo ""
echo "🔄 Committing..."
git add test*.*
git commit -m "Test universal comment support"

echo ""
echo "📋 After (all should show current date):"
grep "Current Date and Time\|Current User's Login" test*.* || true

echo ""
echo "✅ Universal test completed!"
