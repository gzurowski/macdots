#!/usr/bin/env bash

DOWNLOADS_DIR="$HOME/Downloads"
LOG_FILE="$HOME/Library/Logs/cleanup_downloads.log"
DAYS=7
USE_TRASH=1
SKIP_PATTERNS=(
  -not -name "*.crdownload"
  -not -name "*.download"
  -not -name "*.partial"
)

echo ">> Cleanup started at $(date)" >> "$LOG_FILE"

# Remove old .DS_Store files first
find "$DOWNLOADS_DIR" -name ".DS_Store" -mtime +$DAYS -delete 2>> "$LOG_FILE"

# Remove files
find "$DOWNLOADS_DIR" -type f -mtime +$DAYS "${SKIP_PATTERNS[@]}" -print0 | while IFS= read -r -d '' file; do
    if (( USE_TRASH )); then
        echo "Moving to trash: $file" >> "$LOG_FILE"
        trash "$file" 2>> "$LOG_FILE"
    else
        echo "Removing $file" >> "$LOG_FILE"
        rm -f "$file" 2>> "$LOG_FILE"
    fi
done

# Remove directories that are old and either empty or only contain .DS_Store
find "$DOWNLOADS_DIR" -mindepth 1 -type d -Btime +$DAYS -print0 | while IFS= read -r -d '' dir; do
    # Check if directory is empty or only has .DS_Store
    file_count=$(find "$dir" -maxdepth 1 -type f ! -name ".DS_Store" 2>/dev/null | wc -l)
    if [ "$file_count" -eq 0 ]; then
        # Remove .DS_Store if present
        rm -f "$dir/.DS_Store" 2>/dev/null
        
        if (( USE_TRASH )); then
            echo "Moving empty directory to trash: $dir" >> "$LOG_FILE"
            trash "$dir" 2>> "$LOG_FILE"
        else
            echo "Removing empty directory: $dir" >> "$LOG_FILE"
            rmdir "$dir" 2>> "$LOG_FILE"
        fi
    fi
done

echo ">> Cleanup completed at $(date)" >> "$LOG_FILE"
