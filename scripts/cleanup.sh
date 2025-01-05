#!/bin/bash
set -e

# Remove .env file
echo "Removing .env file..."
rm -f .env

# Remove any temporary files
echo "Cleaning up temporary files..."
rm -f config/secrets.json
rm -f *.tmp

# Remove docker containers and volumes (optional)
read -p "Do you want to remove all related Docker containers and volumes? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker-compose down -v
fi

echo "Cleanup completed!" 