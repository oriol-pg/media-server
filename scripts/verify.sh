#!/bin/bash
set -e

CHECKSUM_FILE="config/secrets.json.sha256"
ENCRYPTED_FILE="config/secrets.json.gpg"

# Check if files exist
if [ ! -f "$ENCRYPTED_FILE" ]; then
    echo "Error: Encrypted secrets file not found!"
    exit 1
fi

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "Error: Checksum file not found!"
    exit 1
fi

# Verify file existence and permissions
echo "Verifying files..."
if [ ! -r "$ENCRYPTED_FILE" ]; then
    echo "Error: Cannot read encrypted file!"
    exit 1
fi

echo "All verification checks passed!" 