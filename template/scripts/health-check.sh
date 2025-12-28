#!/bin/bash
# Container health monitoring script
# Sends Telegram alert when containers become unhealthy
# Run via cron: */5 * * * * /root/__#TEMPLATE#:DOMAIN__/scripts/health-check.sh

STATE_FILE="/tmp/container-health-state"
SCRIPT_DIR="$(dirname "$0")"

# Source DOMAIN from .env
ENV_FILE="$SCRIPT_DIR/../docker/.env"
if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
fi

# Get unhealthy containers
UNHEALTHY=$(docker ps --filter "health=unhealthy" --format "{{.Names}}")

if [ -n "$UNHEALTHY" ]; then
  # Check if this is a new failure (not in state file)
  if ! grep -Fxq "$UNHEALTHY" "$STATE_FILE" 2>/dev/null; then
    # Send Telegram notification
    "$SCRIPT_DIR/telegram-notify.sh" "🚨 Container Health Alert - $DOMAIN" \
"The following container(s) are unhealthy:

<code>$UNHEALTHY</code>

Check status with: <code>docker ps</code>
View logs with: <code>docker logs [container-name]</code>
Or use lazydocker for interactive management."

    echo "$UNHEALTHY" >> "$STATE_FILE"
  fi
else
  # All healthy, clear state
  > "$STATE_FILE"
fi
