#!/bin/sh
while true; do
  if [ -f "$TRIGGER_FILE" ]; then
    echo "[NGINX] Detected renewed certificate, reloading NGINX..."
    nginx -s reload
    rm "$TRIGGER_FILE"
  fi
  sleep 60
done
