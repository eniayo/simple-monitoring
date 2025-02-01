#!/bin/bash

echo "Starting Netdata Cleanup..."

# Stop and remove Netdata container
if docker ps -a | grep -q netdata; then
    echo "Stopping Netdata container..."
    docker stop netdata
    
    echo "Removing Netdata container..."
    docker rm netdata
    
    echo "Cleanup completed successfully!"
else
    echo "Netdata container not found. Nothing to clean up."
fi

# Optional: Remove Netdata image
read -p "Do you want to remove the Netdata Docker image as well? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker rmi netdata/netdata
    echo "Netdata image removed."
fi
