#!/bin/bash
# BashWatch: monitor folder, fix ownership & permissions

# Load environment config
ENV_FILE="/opt/secure_envs/bashwatch.env"
if [ ! -f "$ENV_FILE" ]; then
    echo "❌ Env file missing at $ENV_FILE"
    exit 1
fi
source "$ENV_FILE"

# Verify required vars
if [ -z "$WATCH_DIR" ] || [ -z "$FILE_OWNER" ] || [ -z "$FILE_GROUP" ]; then
    echo "❌ Missing required variables in $ENV_FILE"
    exit 1
fi

# Validate permission value
if ! [[ "$FILE_PERMISSIONS" =~ ^[0-7]{3}$ ]]; then
    echo "⚠️ Invalid FILE_PERMISSIONS ($FILE_PERMISSIONS), using default 750"
    FILE_PERMISSIONS=750
fi

# Ensure inotify-tools is installed
if ! command -v inotifywait &> /dev/null; then
    echo "❌ inotifywait not found, please install inotify-tools"
    exit 1
fi

echo "👀 Watching $WATCH_DIR for new files..."

inotifywait -m -e create -e moved_to "$WATCH_DIR" --format "%f" | while read FILE; do
    FULL_PATH="$WATCH_DIR/$FILE"

    if [ -f "$FULL_PATH" ]; then
        chmod "$FILE_PERMISSIONS" "$FULL_PATH" 2>> /var/log/bashwatch.log
        chown "$FILE_OWNER:$FILE_GROUP" "$FULL_PATH" 2>> /var/log/bashwatch.log
        echo "✅ $FULL_PATH → chmod $FILE_PERMISSIONS, chown $FILE_OWNER:$FILE_GROUP" >> /var/log/bashwatch.log
    fi
done
