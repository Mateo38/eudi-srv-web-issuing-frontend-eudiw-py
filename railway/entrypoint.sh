#!/bin/bash
set -e

CONFIG="/app/railway/frontend_config.yaml"

# Substitute URLs from environment variables if set
if [ -n "$SERVICE_URL" ]; then
  sed -i "s|service_url:.*|service_url: \"$SERVICE_URL\"|" "$CONFIG"
  sed -i "s|oauth_url:.*|oauth_url: \"$SERVICE_URL/oidc\"|" "$CONFIG"
fi

if [ -n "$BACKEND_URL" ]; then
  sed -i "s|backend_url:.*|backend_url: \"$BACKEND_URL\"|" "$CONFIG"
fi

# Create log directory
mkdir -p /tmp/logs

# Export config path
export ISSUER_CONFIG_PATH="$CONFIG"

# Start Flask on the correct port (Railway uses $PORT)
exec flask run --host=0.0.0.0 --port="${PORT:-5000}"
