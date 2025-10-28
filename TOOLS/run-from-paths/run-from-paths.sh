#!/bin/bash
# run-from-paths.sh - Run files based on full path
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
# Version: 2025.0.0.1
# Created: 2025-07-05 11:28:00 UTC
# License: Proprietary
# Author: Róbert Kovács (ncoldwave)
#
# Description: Run files based on full path
# Usage: ./run-from-paths.sh [--help] [--help-hu]
#
# Dependencies: read, sed
#
# Security Notice: This script contains proprietary automation procedures.
#                 Do not share or modify without explicit authorization.
#
# Legal Notice: For legal compliance and audit purposes, all executions
#              of this script are logged and monitored.

CONFIG_FILE="runlist.txt"

# === HELP ===
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  echo "🛠️ Run files based on full path"
  echo
  echo "Usage:"
  echo " ./run-from-paths.sh [--help] [--help-hu]"
  echo
  echo "Read files to run from '${CONFIG_FILE}'."
  echo "Each line should be a full path. Comments start with '#'."
  echo
  exit 0
fi

# === HELP HUN ===
if [[ "$1" == "--help-hu" || "$1" == "-h-hu" ]]; then
    echo "🛠️  Fájlok futtatása teljes elérési útvonal alapján"
    echo
    echo "Használat:"
    echo "  ./run-from-paths.sh [--help] [--help-hu]"
    echo
    echo "A '${CONFIG_FILE}' fájlból olvassa be a futtatandó fájlokat."
    echo "Minden sor egy teljes elérési út legyen. Kommentek '#' jellel kezdődnek."
    echo
    exit 0
fi

# === Konfigurációs fájl ellenőrzése ===
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Konfigurációs fájl nem található: $CONFIG_FILE"
    exit 1
fi

echo "🚀 Futtatás indul: $CONFIG_FILE"
echo

# === Soronkénti feldolgozás ===
while IFS= read -r line || [ -n "$line" ]; do
    trimmed=$(echo "$line" | sed 's/^[[:space:]]*//')

    [[ -z "$trimmed" || "$trimmed" =~ ^# ]] && continue

    if [ ! -x "$trimmed" ]; then
        echo "❌ Nem futtatható vagy nem található: $trimmed"
        continue
    fi

    echo "▶️  Futtatás: $trimmed"
    "$trimmed"
    echo
done < "$CONFIG_FILE"

echo "✅ Minden futtatás befejezve."
