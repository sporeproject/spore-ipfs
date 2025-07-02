#!/bin/sh

set -e

# Initialize IPFS if it hasn't been already
if [ ! -d "/data/ipfs/blocks" ]; then
  echo "Initializing IPFS..."
  ipfs init
fi


# Start IPFS daemon
echo "Starting IPFS daemon..."
exec ipfs daemon

