#!/bin/bash

# Check if directory argument is provided
if [ -z "$1" ]; then
    echo "Usage: ./backup.sh <directory_to_backup>"
    exit 1
fi

# Directory to backup
DIR_TO_BACKUP="$1"

# Check if directory exists
if [ ! -d "$DIR_TO_BACKUP" ]; then
    echo "Error: Directory '$DIR_TO_BACKUP' does not exist."
    exit 1
fi

# Create backups folder if it doesn't exist
mkdir -p ./backups
LOGFILE="./backups/backup.log"

# Timestamp for backup file
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="./backups/backup_$TIMESTAMP.tar.gz"

# Create compressed backup
tar -czf "$BACKUP_FILE" "$DIR_TO_BACKUP"

# Log the backup activity
echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup created: $BACKUP_FILE" >> "$LOGFILE"

# Keep only the last 5 backups
BACKUPS_TO_KEEP=5
TOTAL_BACKUPS=$(ls -1 ./backups/backup_*.tar.gz 2>/dev/null | wc -l)

if [ "$TOTAL_BACKUPS" -gt "$BACKUPS_TO_KEEP" ]; then
    # Delete older backups
    ls -1t ./backups/backup_*.tar.gz | tail -n +$((BACKUPS_TO_KEEP + 1)) | xargs rm -f
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Old backups removed" >> "$LOGFILE"
fi

# Confirm
echo "Backup completed: $BACKUP_FILE"
