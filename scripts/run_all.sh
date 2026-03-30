#!/bin/bash
set -euo pipefail

# Create logs folder if it doesn't exist
mkdir -p ./logs
LOGFILE="./logs/app.log"

# Helper function to log actions
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
}

# Run system check
system_check() {
    echo "Running system check..."
    log_action "Started system check"
    if ./scripts/system_check.sh; then
        log_action "System check completed successfully"
    else
        log_action "System check failed"
    fi
}

# Run backup
backup() {
    echo "Enter directory to backup:"
    read DIR
    log_action "Started backup for $DIR"
    if ./scripts/backup.sh "$DIR"; then
        log_action "Backup completed successfully for $DIR"
    else
        log_action "Backup failed for $DIR"
    fi
}

# Run all scripts
run_all() {
    system_check
    echo "Enter directory to backup for run all:"
    read DIR
    backup "$DIR"
    echo "All scripts executed."
    log_action "All scripts executed"
}

# Interactive menu
while true; do
    echo "----------------------"
    echo "1) Run all"
    echo "2) System check"
    echo "3) Backup"
    echo "4) Exit"
    echo "----------------------"
    read -p "Select an option [1-4]: " choice

    case "$choice" in
        1)
            run_all
            ;;
        2)
            system_check
            ;;
        3)
            backup
            ;;
        4)
            echo "Exiting..."
            log_action "Application exited"
            exit 0
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
done
