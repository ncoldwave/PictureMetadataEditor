#!/bin/bash

# multi-copy.sh - Copy multiple files based on a configuration file
#
# Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted): 2025-07-06 08:04:02
# Current User's Login: ncoldwave
#
#  Copyright (c) Róbert Kovács. All rights reserved.
#  Proprietary and confidential.
#
#  This script is licensed for use exclusively by UniVital.Net until revoked.
#  Unauthorized use, copying, modification, or distribution is strictly prohibited.
#  License remains valid until explicitly revoked by the copyright holder.
#
#  Contact:        legal@univital.net, robbi.mobile@gmail.com
#  Repository:     https://github.com/ncoldwave/Design-Media
#
# Version:         2025.0.0.2
# License:         Proprietary
# Author:          Róbert Kovács (ncoldwave)
#
# Description:     This script copies files to multiple destination folders based on a configuration file.
# Usage:           ./multi-copy.sh [--help-hu] [--help]
#
# Dependencies:    bash, cp, mkdir, sed
#
# Security Notice: This script contains proprietary automation procedures.
#                  Do not share or modify without explicit authorization.
#
# Legal Notice:    For legal compliance and audit purposes, all executions
#                  of this script are logged and monitored.

CONFIG_FILE="copy-config.txt"

# === 📘 Show help ===
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "🛠️ Copy multiple files based on configuration file"
    echo
    echo "Usage:"
    echo " ./multi-copy.sh [--help] [--help-hu]"
    echo
    echo "The script reads the copy instructions from the file '${CONFIG_FILE}'."
    echo "Format of each line:"
    echo " /full/path/source_file /path/1 /path/2 ..."
    echo
    echo "Example:"
    echo " /mnt/c/Users/ncoldwave/file.txt /mnt/d/Backup /mnt/e/Archive"
    echo
    echo "Comments:"
    echo " Ignore lines starting with '#' or empty lines."
    echo
    exit 0
fi

# === 📘 Show Hungarian help ===
if [[ "$1" == "--help-hu" || "$1" == "-h-hu" ]]; then
    echo "🛠️  Több fájl másolása konfigurációs fájl alapján"
    echo
    echo "Használat:"
    echo "  ./multi-copy.sh [--help] [--help-hu]"
    echo
    echo "A script a '${CONFIG_FILE}' fájlból olvassa be a másolási utasításokat."
    echo "Minden sor formátuma:"
    echo "  /teljes/elérési/út/forras_fajl /cel/utvonal1 /cel/utvonal2 ..."
    echo
    echo "Példa:"
    echo "  /mnt/c/Users/ncoldwave/file.txt /mnt/d/Backup /mnt/e/Archive"
    echo
    echo "Kommentek:"
    echo "  A '#' jellel kezdődő vagy üres sorokat figyelmen kívül hagyja."
    echo
    exit 0
fi

#!/bin/bash

# Configuration file path
CONFIG_FILE="./.copy-config"

# Hibatárolók
missing_sources=()
failed_destinations=()

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ Configuration file not found: $CONFIG_FILE"
  exit 1
fi

echo "📄 Loading configuration: $CONFIG_FILE"
echo

# Process the configuration line by line
while IFS= read -r line || [ -n "$line" ]; do
    # Removing leading and inner whitespace
    trimmed=$(echo "$line" | sed 's/^[[:space:]]*//')

    # Skip blank or comment lines
    [[ -z "$trimmed" || "$trimmed" =~ ^# ]] && continue

    # Split line into source and destinations
    read -ra parts <<< "$trimmed"
    SOURCE="${parts[0]}"
    DESTINATIONS=("${parts[@]:1}")

    # Check source file
    if [ ! -f "$SOURCE" ]; then
        echo "❌ Source not found: $SOURCE"
        missing_sources+=("$SOURCE")
        continue
    fi

    echo "📤 Copying: $SOURCE"
    for dest in "${DESTINATIONS[@]}"; do
        # Create destination folder if it does not exist
        if [ ! -d "$dest" ]; then
            echo "📁 Creating destination folder: $dest"
            mkdir -p "$dest" || {
                echo "❌ Failed to create: $dest"
                failed_destinations+=("$dest")
                continue
            }
        fi

        cp -v "$SOURCE" "$dest"
    done
    echo
done < "$CONFIG_FILE"

# Summary
echo "✅ Copy operation completed."
echo

if [ ${#missing_sources[@]} -gt 0 ]; then
  echo "⚠️  Missing source files:"
  for src in "${missing_sources[@]}"; do
    echo "   - $src"
  done
  echo
fi

if [ ${#failed_destinations[@]} -gt 0 ]; then
  echo "⚠️  Failed to create destination folders:"
  for dst in "${failed_destinations[@]}"; do
    echo "   - $dst"
  done
  echo
fi

if [ ${#missing_sources[@]} -eq 0 ] && [ ${#failed_destinations[@]} -eq 0 ]; then
  echo "🎉 All operations completed successfully."
else
  echo "❗ Some issues occurred during the copy process."
fi

