#!/bin/sh

set -e

CONFIG_FILE="/data/ipfs/config"

# Initialize if needed
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Initializing IPFS..."
  ipfs init
fi

# Patch config if needed
API_ADDR=$(jq -r '.Addresses.API' "$CONFIG_FILE")
GATEWAY_ADDR=$(jq -r '.Addresses.Gateway' "$CONFIG_FILE")

if [ "$API_ADDR" = "/ip4/127.0.0.1/tcp/5001" ]; then
  echo "Fixing API bind address..."
  ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
fi

if [ "$GATEWAY_ADDR" = "/ip4/127.0.0.1/tcp/8080" ]; then
  echo "Fixing Gateway bind address..."
  ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
fi

echo "Starting IPFS daemon..."
exec ipfs daemon
