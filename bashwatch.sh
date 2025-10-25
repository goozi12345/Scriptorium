#!/bin/bash

# === Bashwatch ===
# Automatically sets permissions and ownership for new files and folders

# Load environment variables securely
source /opt/secure_envs/bashwatch.env

# Ensure inotify-tools is installed
if ! command -v inotifywait &> /dev/null; then
    echo "❌ inotifywait could not be found, please install inotify-tools (sudo apt install inotify-tools)."
    exit 1
fi

# Check that watch folder exists
if [ ! -d "$WATCH_DIR" ]; then
    echo "❌ Directory not found: $WATCH_DIR"
    exit 1
fi

echo "👀 Watching folder: $WATCH_DIR"
echo "Using permissions: 750"
echo "Setting owner: $OWNER_USER:$OWNER_GROUP"

# Watch folder for new files or folders
inotifywait -m -r -e create -e moved_to "$WATCH_DIR" --format "%w%f" | while read -r FULL_PATH; do
    if [ -f "$FULL_PATH" ]; then
        # New file: set permissions and owner
        chmod 750 "$FULL_PATH"
        chown "$OWNER_USER":"$OWNER_GROUP" "$FULL_PATH"
        echo "✅ File updated: $FULL_PATH → perms 750, owner $OWNER_USER:$OWNER_GROUP"
    elif [ -d "$FULL_PATH" ]; then
        # New folder: set permissions and owner recursively
        chmod -R 750 "$FULL_PATH"
        chown -R "$OWNER_USER":"$OWNER_GROUP" "$FULL_PATH"
        echo "✅ Folder updated recursively: $FULL_PATH → perms 750, owner $OWNER_USER:$OWNER_GROUP"
    fi
done
