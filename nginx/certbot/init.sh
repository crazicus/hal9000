#!/bin/sh
set -e

echo "[Certbot] Startup script running..."

# Request wildcard certificate if it doesn't exist
if [ ! -d "/etc/letsencrypt/live/$DOMAIN" ]; then
    echo "[Certbot] No certificate for $DOMAIN — requesting wildcard certificate..."
    certbot certonly \
        --dns-cloudflare \
        --dns-cloudflare-credentials $CREDENTIALS \
        -d "$DOMAIN" -d "*.$DOMAIN" \
        --non-interactive --agree-tos \
        --email "$EMAIL" \
        --server https://acme-v02.api.letsencrypt.org/directory
    touch $TRIGGER_FILE
else
    echo "[Certbot] Wildcard certificate already exists, skipping issuance..."
fi

echo "[Certbot] Entering auto-renew loop..."
while true; do
    if certbot renew --dns-cloudflare --dns-cloudflare-credentials $CREDENTIALS --quiet; then
        echo "[Certbot] Certificate renewed successfully, touching trigger file..."
        touch $TRIGGER_FILE
    fi
    sleep 12h
done
