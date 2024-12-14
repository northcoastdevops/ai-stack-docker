#!/bin/bash

# Create SSL directory if it doesn't exist
mkdir -p ssl

# Generate certificates using certbot
certbot certonly \
    --standalone \
    --non-interactive \
    --agree-tos \
    --email your-email@domain.com \
    -d ai.internal \
    -d search.internal \
    --deploy-hook "docker exec nginx nginx -s reload"

# Create symlinks to the certbot certificates
ln -sf /etc/letsencrypt/live/ai.internal/fullchain.pem ssl/ai.internal.crt
ln -sf /etc/letsencrypt/live/ai.internal/privkey.pem ssl/ai.internal.key
ln -sf /etc/letsencrypt/live/search.internal/fullchain.pem ssl/search.internal.crt
ln -sf /etc/letsencrypt/live/search.internal/privkey.pem ssl/search.internal.key

# Set proper permissions
chmod 600 ssl/*.key
chmod 644 ssl/*.crt 