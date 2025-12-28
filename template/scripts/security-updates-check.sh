#!/bin/bash
# Security updates checker
# Sends weekly Telegram notification if security updates are available
# Run via cron: 0 9 * * 0 /root/__#TEMPLATE#:DOMAIN__/scripts/security-updates-check.sh

SCRIPT_DIR="$(dirname "$0")"

# Source DOMAIN from .env
ENV_FILE="$SCRIPT_DIR/../docker/.env"
if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
fi

# Check for security updates
UPDATES=$(apt list --upgradable 2>/dev/null | grep -i security)
COUNT=$(echo "$UPDATES" | grep -c "^" 2>/dev/null || echo 0)

if [ "$COUNT" -gt 0 ]; then
  "$SCRIPT_DIR/telegram-notify.sh" "🔒 Security Updates - $DOMAIN" \
"There are <b>$COUNT</b> security update(s) available:

<code>$UPDATES</code>

To install updates, run:
<code>apt update && apt upgrade</code>"
fi
