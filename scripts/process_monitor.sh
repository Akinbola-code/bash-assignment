#!/bin/bash

# List of services to monitor
services=("nginx" "ssh" "docker")

# Create logs folder if it doesn't exist
mkdir -p ./logs
LOGFILE="./logs/process_monitor.log"

# Check if user provided a process name
if [ -z "$1" ]; then
    echo "Usage: ./process_monitor.sh <process_name>"
    exit 1
fi

PROCESS="$1"
STATUS=""

# Check if process is in the array of monitored services
if [[ ! " ${services[@]} " =~ " $PROCESS " ]]; then
    echo "Error: $PROCESS is not in monitored services: ${services[*]}"
    exit 1
fi

# Check if process is running
if pgrep "$PROCESS" > /dev/null; then
    STATUS="Running"
    echo "$PROCESS is running."
else
    STATUS="Stopped"
    echo "$PROCESS is stopped."
    
    # Simulate restart
    echo "Attempting to restart $PROCESS..."
    sleep 1  # simulate restart time
    STATUS="Restarted"
    echo "$PROCESS restarted."
fi

# Log the monitoring result
echo "$(date '+%Y-%m-%d %H:%M:%S') - $PROCESS: $STATUS" >> "$LOGFILE"
