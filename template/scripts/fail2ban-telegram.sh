#!/bin/bash
# fail2ban Telegram notification script
# Called by fail2ban when an IP is banned

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

# fail2ban passes these via environment or arguments
JAIL="${1:-unknown}"
IP="${2:-unknown}"

TEXT="<b>🚫 fail2ban Ban - $DOMAIN</b>

Jail: <code>$JAIL</code>
IP: <code>$IP</code>

An IP has been banned for suspicious activity."

# Send via Telegram Bot API
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "parse_mode=HTML" \
  -d "text=${TEXT}" > /dev/null
