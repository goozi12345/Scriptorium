#!/bin/bash

# Folder to watch
WATCH_DIR=/home/goozi/Data/Comics

# Ensure inotify-tools is installed
if ! command -v inotifywait &> /dev/null
then
    echo "inotifywait could not be found, please install inotify-tools."
    exit 1
fi

echo "Watching folder: $WATCH_DIR for new files..."

# Infinite loop to watch for new files
inotifywait -m -e create -e moved_to "$WATCH_DIR" --format "%f" | while read FILE
do
    FULL_PATH="$WATCH_DIR/$FILE"
    
    if [ -f "$FULL_PATH" ]; then
        chmod 755 "$FULL_PATH"
        echo "Permissions for $FULL_PATH set to 755."
    fi
done
