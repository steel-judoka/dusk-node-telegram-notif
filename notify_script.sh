#!/bin/bash 
BOT_TOKEN="your_telegram_bot_token" 
CHAT_ID="your_chat_id" 
LOG_CONTENT=$(cat /tmp/rusk_output.log) 
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" -d chat_id="${CHAT_ID}" -d text="Rusk Log Update: ${LOG_CONTENT}"