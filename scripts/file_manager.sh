#!/bin/bash#

# Create logs folder if it doesn't exist
mkdir -p ./logs

# Log file
LOGFILE="./logs/file_manager.log"

# Get command and arguments
COMMAND=$1
ARG1=$2
ARG2=$3
case $COMMAND in

    create)
        if [ -z "$ARG1" ]; then
            echo "Error: No file specified to create."
        elif [ -e "$ARG1" ]; then
            echo "Error: $ARG1 already exists. Not overwriting."
        else
            touch "$ARG1"
            echo "File created: $ARG1"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Created file: $ARG1" >> "$LOGFILE"
        fi
        ;;

    delete)
        if [ -z "$ARG1" ]; then
            echo "Error: No file specified to delete."
        elif [ ! -e "$ARG1" ]; then
            echo "Error: $ARG1 does not exist."
        else
            rm "$ARG1"
            echo "File deleted: $ARG1"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Deleted file: $ARG1" >> "$LOGFILE"
        fi
        ;;

    list)
        echo "Files in current directory:"
        ls
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Listed files" >> "$LOGFILE"
        ;;

    rename)
        if [ -z "$ARG1" ] || [ -z "$ARG2" ]; then
            echo "Error: Specify old and new file names."
        elif [ ! -e "$ARG1" ]; then
            echo "Error: $ARG1 does not exist."
        elif [ -e "$ARG2" ]; then
            echo "Error: $ARG2 already exists. Not overwriting."
        else
            mv "$ARG1" "$ARG2"
            echo "File renamed: $ARG1 → $ARG2"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Renamed $ARG1 to $ARG2" >> "$LOGFILE"
        fi
        ;;

    *)
        echo "Unknown command. Use: create, delete, list, rename"
        ;;
esac
