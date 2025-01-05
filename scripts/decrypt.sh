#!/bin/bash
set -e

PASSWORD=$1
ENCRYPTED_FILE="config/secrets.json.gpg"
TEMP_DIR=$(mktemp -d)

# Cleanup on exit
trap 'rm -rf "$TEMP_DIR"' EXIT

# Decrypt file
gpg --batch --yes --passphrase="$PASSWORD" \
    --decrypt "$ENCRYPTED_FILE" > "$TEMP_DIR/secrets.json"

# Create .env file
echo "Creating .env file..."
echo "VPN_USER=$(jq -r '.vpn_user' "$TEMP_DIR/secrets.json")" > .env
echo "VPN_PASSWORD=$(jq -r '.vpn_password' "$TEMP_DIR/secrets.json")" >> .env
echo "VPN_COUNTRIES=$(jq -r '.vpn_countries' "$TEMP_DIR/secrets.json")" >> .env

echo ".env file created successfully!" 