#!/bin/bash

# === Bashwatch ===
# Automatically sets permissions and ownership for new files

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
echo "Using permissions: $PERMISSIONS"
echo "Setting owner: $OWNER_USER:$OWNER_GROUP"

# Start watching for new files
inotifywait -m -e create -e moved_to "$WATCH_DIR" --format "%w%f" | while read -r FULL_PATH; do
    if [ -f "$FULL_PATH" ]; then
        chmod "$PERMISSIONS" "$FULL_PATH"
        chown "$OWNER_USER":"$OWNER_GROUP" "$FULL_PATH"
        echo "✅ Updated $FULL_PATH → perms $PERMISSIONS, owner $OWNER_USER:$OWNER_GROUP"
    fi
done
