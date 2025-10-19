# Pre-commit Hook Setup Guide

## 🎯 Overview

This guide sets up an optimized pre-commit hook for the METASYSTEM_SCC Legal System that automatically updates metadata in files before each commit.

## 📋 Features

* **⚡ Fast Performance**: Only processes staged files (1-2 seconds)
* **📅 Accurate Timestamps**: Uses current UTC time
* **👤 User Tracking**: Updates user login information
* **🛡️ Safe Operation**: Creates backups and validates changes
* **📊 Detailed Feedback**: Shows exactly what was modified

## 🔧 Installation

### Step 1: Fix Hook Location

```bash
chmod +x <install-precommit.sh>
./<install-precommit.sh>
```

## 📁 Supported Metadata Fields

The hook automatically updates these metadata fields in files:

| Field Pattern | Example |
|---------------|---------|
| `Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted):` | `2025-01-27 21:40:58` |
| `Current User's Login:` | `ncoldwave` |
| `Last Modified:` | `2025-01-27 21:40:58` |
| `Updated:` | `2025-01-27 21:40:58` |

## 📂 Supported File Types

* `.md` (Markdown)
* `.txt` (Text)
* `.yml`, `.yaml` (YAML)
* `.json` (JSON)
* `.php` (PHP)
* `.sh` (Shell scripts)
* `.py` (Python)

## 🎯 How It Works

1. **Trigger**: Activates automatically on `git commit`
2. **Scope**: Only processes files in the staging area (`git add`)
3. **Detection**: Searches for metadata patterns in relevant files
4. **Update**: Replaces old timestamps/usernames with current values
5. **Re-stage**: Automatically adds updated files back to staging area

## 🧪 Testing

### Manual Test

```bash
# Create a test file with metadata
echo "Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-01 17:14:57" > test.md
echo "Current User's Login: ncoldwave

# Stage and commit
git add test.md
git commit -m "Test commit"

# Check if metadata was updated
cat test.md
```

### Verify Hook Installation

```bash
# Check if hook exists and is executable
ls -la .git/hooks/pre-commit

# Test hook permissions
test -x .git/hooks/pre-commit && echo "✅ Executable" || echo "❌ Not executable"

# Manual hook execution (for debugging)
.git/hooks/pre-commit
```

## 🚨 Troubleshooting

### Hook Not Running

```bash
# Check hook location (must be in .git/hooks/)
ls -la .git/hooks/pre-commit

# Fix permissions
chmod +x .git/hooks/pre-commit

# Verify git repository
git status
```

### Hook Running But Not Updating

```bash
# Check file patterns
echo "Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-01 17:14:57" > debug.md
git add debug.md

# Run hook manually with debug output
.git/hooks/pre-commit

# Check for changes
git diff --cached debug.md
```

### Performance Issues

* Hook only processes staged files (fast)
* Skips binary files automatically
* Uses efficient sed commands
* Creates minimal backups

## 📊 Performance Metrics for one pre-commit hook

| Scenario | Time | Files Processed |
|----------|------|-----------------|
| Single file | ~0.1s | 1 |
| 10 files | ~0.5s | 10 |
| 50 files | ~1.5s | 50 |
| 100+ files | ~2-3s | 100+ |

## 🔒 Security Features

* **No External Dependencies**: Uses only built-in Unix tools
* **Backup Creation**: Temporary backups before modification
* **Change Validation**: Verifies modifications before staging
* **Safe Patterns**: Only matches specific metadata formats
* **UTF-8 Support**: Handles international characters correctly

## 📝 Customization

### Add New Metadata Fields

Edit `.git/hooks/pre-commit` and add new sed patterns:

```bash
sed -i \
    -e "s/Your Pattern: [0-9-]* [0-9:]*/Your Pattern: $CURRENT_UTC/g" \
    "$file"
```

### Add New File Types

Update the file pattern in the hook:

```bash
RELEVANT_FILES=$(echo "$STAGED_FILES" | grep -E '\.(md|txt|your_extension)$' || true)
```

## 🔄 Maintenance

### Update Hook

```bash
# Re-run installation to update hook
./install-precommit.sh
```

### Disable Hook Temporarily

```bash
# Rename hook file
mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled
```

### Commit without hook

```bash
git commit -m "Commit without hook"
```

### Re-enable

```bash
mv .git/hooks/pre-commit.disabled .git/hooks/pre-commit
```

### Remove Hook

```bash
rm .git/hooks/pre-commit
```

## ✅ Verification Checklist

* [X] Hook file exists: `.git/hooks/pre-commit`
* [X] Hook is executable: `chmod +x .git/hooks/pre-commit`
* [X] Test file with metadata patterns works and removed
* [X] Hook updates timestamps to current UTC
* [X] Hook updates username correctly
* [X] Performance is acceptable (< 3 seconds)
* [X] No error messages during commit

## 📞 Support

For issues or questions:

* Check this documentation first
* Verify hook location and permissions
* Test with simple files first
* Check git repository status

---

*Last Updated: July 01, 2025, 17:23 UTC*  
*Maintained by*: METASYSTEM_SCC Legal System Team

© 2025 Robert Kovacs. All rights reserved.
