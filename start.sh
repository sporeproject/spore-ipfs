#!/bin/sh

set -e

# Initialize IPFS if it hasn't been already
if [ ! -d "/data/ipfs/blocks" ]; then
  echo "Initializing IPFS..."
  ipfs init
fi

# Set storage max from env, default to 10GB
if [ -n "$IPFS_STORAGE_MAX" ]; then
  echo "Setting IPFS storage limit to $IPFS_STORAGE_MAX"
  ipfs config Datastore.StorageMax "$IPFS_STORAGE_MAX"
fi

# Start IPFS daemon
echo "Starting IPFS daemon..."
exec ipfs daemon

