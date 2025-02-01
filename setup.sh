#!/bin/bash

echo "Starting Netdata Setup..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Stop and remove existing container if it exists
if docker ps -a | grep -q netdata; then
    echo "Removing existing Netdata container..."
    docker stop netdata
    docker rm netdata
fi

# Start Netdata container
echo "Starting Netdata container..."
docker run -d --name=netdata \
    -p 19999:19999 \
    --cap-add SYS_PTRACE \
    -v /proc:/host/proc:ro \
    -v /sys:/host/sys:ro \
    netdata/netdata

# Wait for container to start
echo "Waiting for Netdata to start..."
sleep 10

# Check if container is running
if docker ps | grep -q netdata; then
    echo "Netdata is running successfully!"
    echo "Access the dashboard at http://localhost:19999"
else
    echo "Failed to start Netdata container. Please check Docker logs."
    exit 1
fi
