#!/bin/sh
set -e

CONFIG=/data/ipfs/config
LOCK=/data/ipfs/repo.lock
STORAGEMAX=${IPFS_STORAGE_MAX:-10GB}   # default 10 GB, overridable by env

# 1. repo initialisation (first boot only)
if [ ! -f "$CONFIG" ]; then
  echo "[init] fresh repo"
  ipfs init
fi

# 2. clear stale lock left by the previous container (dokku rebuilds fast)
if [ -f "$LOCK" ]; then
  echo "[unlock] removing stale repo.lock"
  rm -f "$LOCK"
fi

# 3. make sure API & Gateway bind to 0.0.0.0 (one-time patch)
if grep -q '"API": "/ip4/127.0.0.1/tcp/5001"' "$CONFIG"; then
  echo "[patch] fixing API bind addr"
  ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
fi
if grep -q '"Gateway": "/ip4/127.0.0.1/tcp/8080"' "$CONFIG"; then
  echo "[patch] fixing Gateway bind addr"
  ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
fi

# 4. enforce storage cap if it changed
CUR=$(ipfs config Datastore.StorageMax)
if [ "$CUR" != "$STORAGEMAX" ]; then
  echo "[patch] setting StorageMax to $STORAGEMAX"
  ipfs config Datastore.StorageMax "$STORAGEMAX"
fi

echo "[start] kubo daemon…"
exec ipfs daemon
