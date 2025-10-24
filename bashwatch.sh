#!/bin/bash

# Path to your secure .env file
ENV_FILE=/opt/secure_envs/bashwatch.env

# Check if the .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "$ENV_FILE not found!"
    exit 1
fi

# Load variables from the .env file (ignoring comments)
export $(grep -v '^#' "$ENV_FILE" | xargs)

# Check that WATCH_DIR and PERMISSIONS are set
if [ -z "$WATCH_DIR" ] || [ -z "$PERMISSIONS" ]; then
    echo "WATCH_DIR or PERMISSIONS not defined in $ENV_FILE"
    exit 1
fi

# Ensure inotify-tools is installed
if ! command -v inotifywait &> /dev/null
then
    echo "inotifywait could not be found, please install inotify-tools."
    exit 1
fi

echo "Watching folder: $WATCH_DIR for new files..."
echo "Setting new files to permissions: $PERMISSIONS"

# Watch folder for new or moved files
inotifywait -m -e create -e moved_to "$WATCH_DIR" --format "%f" | while read FILE
do
    FULL_PATH="$WATCH_DIR/$FILE"
    
    if [ -f "$FULL_PATH" ]; then
        chmod "$PERMISSIONS" "$FULL_PATH"
        echo "Permissions for $FULL_PATH set to $PERMISSIONS."
    fi
done
