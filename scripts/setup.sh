#!/bin/bash
set -e

# Detect OS
if [ "$(uname)" == "Darwin" ]; then
    # MacOS
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install gnupg jq docker docker-compose
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Linux
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install -y gnupg jq docker.io docker-compose
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y gnupg jq docker docker-compose
    fi
fi

# Create necessary directories
mkdir -p config

# Ensure docker is running
if ! docker info >/dev/null 2>&1; then
    sudo systemctl start docker || true
fi

echo "Setup completed successfully!" 