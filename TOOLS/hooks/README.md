# 📄 TOOLS/hooks/README.md

```markdown
# METASYSTEM_SCC™ Pre-Commit Hook Framework

> Automated, secure, and extensible Git pre-commit hook system for the **Design-Media** repository.

---

## 📦 Overview

This framework provides a lightweight, platform-independent pre-commit hook system that:

- ✅ Automatically runs custom scripts before every Git commit
- ✅ Requires no external dependencies (no Python, no `pre-commit` package)
- ✅ Works across Windows, WSL, Linux, and macOS
- ✅ Is fully configurable via `.hook-config`
- ✅ Never overwrites existing hooks — only appends logic
- ✅ Protects hook scripts from modifying each other or the hook itself

---

## 🚀 Installation

From the root of the repository, run:

```bash
bash TOOLS/hooks/install-hooks.sh
```

This will:

1. Ensure `.git/hooks/pre-commit` exists and starts with `#!/bin/bash`
2. Append execution logic for each script listed in `.hook-config`
3. Make the hook executable

You can run the installer multiple times — it will never duplicate or overwrite existing logic.

---

## ⚙️ Configuration

All hook scripts are listed in:

```text
TOOLS/hooks/.hook-config
```

Each line should be a relative path from the repository root. Example:

```ini
# .hook-config
TOOLS/hooks/update-sh-header.sh
TOOLS/hooks/update-md-timestamp.sh
```

> 💡 Comment lines and empty lines are ignored.

---

## 🛡️ Safety & Protections

- Hook scripts automatically skip:
  - Other scripts in `TOOLS/hooks/`
  - The `.git/hooks/pre-commit` file itself
- Scripts are only executed if they are marked as executable (`chmod +x`)
- The installer never overwrites existing pre-commit hooks created by other tools

---

## 🧪 Testing

To test all configured hooks manually:

```bash
bash .git/hooks/pre-commit
```

Or simply try committing a file:

```bash
git commit -m "Test commit"
```

---

## 📁 File Structure

```tree
TOOLS/hooks/
├── install-hooks.sh        # Hook installer
├── .hook-config            # List of scripts to run
├── update-sh-header.sh     # Updates shell script headers
├── update-md-timestamp.sh  # Updates markdown timestamps
└── README.md               # This documentation
```

---

## 🛈 Additional info

To get a file first commit for "Created" fields in the file headers use:

```bash
git log --diff-filter=A --follow --format="%aI" -- path/to/file.js | head -n 1
```

## 📜 License & Legal Notice

© Róbert Kovács. All rights reserved.  
This framework is proprietary and licensed exclusively to **UniVital.Net** until revoked.

Unauthorized use, copying, or modification is strictly prohibited.  
All executions are logged and monitored for legal compliance.

For inquiries:  
📧 <legal@univital.net>  
📧 <robbi.mobile@gmail.com>  
🔗 <https://github.com/ncoldwave/Design-Media>

---

## 🧠 Author

**Róbert Kovács** (`ncoldwave`)  
Project: `METASYSTEM_SCC™ Legal System`  
Component: `Deployment Automation`  
Version: `2025.0.0.1-Preview`

---

© 2025 Robert Kovacs. All rights reserved.
