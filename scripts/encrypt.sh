#!/bin/bash
set -e

PASSWORD=$1
SECRETS_FILE="config/secrets.json"
ENCRYPTED_FILE="config/secrets.json.gpg"
CHECKSUM_FILE="config/secrets.json.sha256"

if [ ! -f "$SECRETS_FILE" ]; then
    echo "Error: secrets.json not found!"
    exit 1
fi

# Validate JSON format
if ! jq empty "$SECRETS_FILE" 2>/dev/null; then
    echo "Error: Invalid JSON format in secrets.json"
    exit 1
fi

# Verify required fields
required_fields=("vpn_user" "vpn_password" "vpn_countries")
for field in "${required_fields[@]}"; do
    if [ "$(jq -r ".$field" "$SECRETS_FILE")" == "null" ]; then
        echo "Error: Missing required field: $field"
        exit 1
    fi
done

# Create checksum before encryption
sha256sum "$SECRETS_FILE" > "$CHECKSUM_FILE"

# Encrypt with GPG
gpg --batch --yes --passphrase="$PASSWORD" \
    --cipher-algo AES256 \
    --symmetric "$SECRETS_FILE"

# Verify encryption was successful
if [ ! -f "$ENCRYPTED_FILE" ]; then
    echo "Encryption failed!"
    exit 1
fi

# Remove original secrets file
rm "$SECRETS_FILE"

# Remove any existing .env file
rm -f .env 