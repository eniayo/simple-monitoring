#!/bin/bash

echo "Starting Netdata Dashboard Test..."

# Function to generate CPU load
generate_load() {
    echo "Generating CPU load for 30 seconds..."
    yes > /dev/null &
    PID=$!
    sleep 30
    kill $PID
}

# Function to generate memory load
generate_memory_load() {
    echo "Generating memory load..."
    python3 -c '
import time
a = []
for i in range(1000000):
    a.append(" " * 100)
    if i % 100000 == 0:
        time.sleep(0.1)
' &
    sleep 20
}

# Check if Netdata is running
if ! docker ps | grep -q netdata; then
    echo "Netdata is not running. Please run setup.sh first."
    exit 1
fi

# Run tests
echo "Running load tests..."
generate_load
echo "CPU load test completed."

generate_memory_load
echo "Memory load test completed."

echo "Test completed. Check the dashboard at http://localhost:19999 to see the results."
