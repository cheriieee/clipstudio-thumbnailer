#!/bin/bash

IN_FILE="$1"
OUT_FILE="$2"

# Search for SQLite header "SQLite format 3"
OFFSET=$(LC_ALL=C grep -aobP "\x53\x51\x4c\x69\x74\x65\x20\x66\x6f\x72\x6d\x61\x74\x20\x33\x00" "$IN_FILE" | head -n 1 | cut -d: -f1)

if [ -z "$OFFSET" ]; then
    exit 1
fi

# Extract database to /tmp
TEMP_DB="/tmp/thumb_$(date +%s%N).sqlite"
dd if="$IN_FILE" of="$TEMP_DB" ibs="$OFFSET" skip=1 status=none

# Extract preview PNG to the destination
sqlite3 "$TEMP_DB" "SELECT writefile('$OUT_FILE', ImageData) FROM CanvasPreview LIMIT 1;" 2>/dev/null

# Clean up
rm -f "$TEMP_DB"
