#!/bin/sh

set -e

# Initialize IPFS if it hasn't been already
if [ ! -f "/data/ipfs/config" ]; then
  echo "Initializing IPFS..."
  ipfs init

  # Ensure the daemon listens on all interfaces
  ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
  ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
fi

# Start IPFS daemon
echo "Starting IPFS daemon..."
exec ipfs daemon
