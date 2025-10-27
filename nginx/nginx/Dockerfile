FROM nginx:latest

# Copy config and watcher script
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY watch-renewal.sh /watch-renewal.sh
RUN chmod +x /watch-renewal.sh

ENTRYPOINT ["sh", "-c", "\
    envsubst '$$DOMAIN $$PICS_SERVICE $$PIHOLE_SERVICE $$HOMEPAGE_SERVICE $$PICS_PORT $$PIHOLE_PORT $$HOMEPAGE_PORT $$TRIGGER_FILE' \
      < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && \
    /watch-renewal.sh & \
    exec nginx -g 'daemon off;'\
"]
