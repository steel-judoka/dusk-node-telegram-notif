#!/bin/bash 
BOT_TOKEN="your_telegram_bot_token" 
CHAT_ID="your_chat_id" 

# Remove the ANSI escape sequences
LOG_CONTENT=$(cat /tmp/rusk_output.log | sed -r "s/\x1B\[[0-9;]*[mK]//g")

# Function to send a message to Telegram
send_message() {
    local MESSAGE="$1"
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="${CHAT_ID}" \
        -d text="${MESSAGE}"
}

# Check if the content exceeds 4096 characters(it's a limit per telegram message)
if [ ${#LOG_CONTENT} -le 4096 ]; then
    # Send the content directly if within the limit
    send_message "${LOG_CONTENT}"
else
    # Split the content into chunks of up to 4096 characters
    CHUNK_SIZE=4096
    START=0
    while [ $START -lt ${#LOG_CONTENT} ]; do
        CHUNK=$(echo "${LOG_CONTENT:$START:$CHUNK_SIZE}")
        send_message "${CHUNK}"
        START=$((START + CHUNK_SIZE))
    done
fi
