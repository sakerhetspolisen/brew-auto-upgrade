#!/bin/bash

# Edit these according to where the files are located
TIMESTAMP_FILE="$HOME/scripts/.brew_auto_upgrade_timestamp"
LOG_FILE="$HOME/scripts/.brew_auto_upgrade_log.txt"
TODAY=$(date +%Y-%m-%d)

# Check if it already ran today
if [ -f "$TIMESTAMP_FILE" ] && [ "$(cat $TIMESTAMP_FILE)" == "$TODAY" ]; then
    exit 0
fi

# Run brew commands and collect the output to the log file
{
    echo "=== Brew Upgrade Log for $TODAY ==="
    echo "Started at $(date +"%Y-%m-%d %H:%M:%S")"
    echo "Running brew update..."
    /opt/homebrew/bin/brew update
    UPDATE_STATUS=$?
    echo "Running brew upgrade..."
    /opt/homebrew/bin/brew upgrade
    UPGRADE_STATUS=$?
    echo "Running brew upgrade --cask..."
    /opt/homebrew/bin/brew upgrade --cask
    UPGRADE_CASKS_STATUS=$?
    echo "Running brew cleanup"
    /opt/homebrew/bin/brew cleanup
    CLEANUP_STATUS=$?
    echo "Completed at $(date +"%Y-%m-%d %H:%M:%S")"
} > "$LOG_FILE" 2>&1

# Update timestamp file
echo "$TODAY" > "$TIMESTAMP_FILE"

# Display notification based on result
if [ $UPDATE_STATUS -eq 0 ] && [ $UPGRADE_STATUS -eq 0 ] && [ $UPGRADE_CASKS_STATUS -eq 0 ] && [ $CLEANUP_STATUS -eq 0 ]; then
    # Success notification
    osascript -e 'display notification "Homebrew packages and casks updated successfully." with title "Brew Update Success" sound name "Purr"'
else
    # First show the notification
    osascript -e 'display notification "There was an issue updating Homebrew packages or casks." with title "Brew Upgrade Failed" sound name "Basso"'

    # Then open Terminal to show the log
    osascript -e 'tell application "Terminal" to activate' -e 'tell application "Terminal" to do script "cat '"$LOG_FILE"'"'
fi

exit 0
