#!/bin/bash
# Telegram notification helper script
# Usage: echo "message" | telegram-notify.sh "Title"
# Or: telegram-notify.sh "Title" "Message"

# Source Telegram credentials from .env
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../docker/.env"

if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
fi

BOT_TOKEN="$TELEGRAM_BOT_TOKEN"
CHAT_ID="$TELEGRAM_CHAT_ID"

# Exit if Telegram not configured
if [ -z "$BOT_TOKEN" ] || [ -z "$CHAT_ID" ]; then
  exit 0
fi

TITLE="$1"
MESSAGE="${2:-$(cat)}"

# Format message with title
TEXT="<b>$TITLE</b>

$MESSAGE"

# Send via Telegram Bot API
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "parse_mode=HTML" \
  -d "text=${TEXT}" > /dev/null
