#!/bin/sh

set -e

CONFIG_FILE="/data/ipfs/config"

# Initialize if needed
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Initializing IPFS..."
  ipfs init
fi

# Patch config if needed
API_ADDR=$(grep '"API"' "$CONFIG_FILE" | head -n1 | sed -E 's/.*: "(.*)",/\1/')
GATEWAY_ADDR=$(grep '"Gateway"' "$CONFIG_FILE" | head -n1 | sed -E 's/.*: "(.*)"/\1/')

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
