#!/bin/bash

# Generate system load
echo "Generating CPU load for testing..."
yes > /dev/null &

# Store PID of load generator
LOAD_PID=$!

# Let system run under load for 2 minutes
sleep 120

# Clean up
kill $LOAD_PID
echo "Load test complete. Check Netdata dashboard for metrics."
