#!/bin/bash
# fail2ban Telegram notification script
# Called by fail2ban when an IP is banned

BOT_TOKEN="{{%INIT_TEMPLATE%:TELEGRAM_BOT_TOKEN}}"
CHAT_ID="{{%INIT_TEMPLATE%:TELEGRAM_CHAT_ID}}"
DOMAIN="{{%INIT_TEMPLATE%:DOMAIN}}"

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
