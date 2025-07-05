# Spore IPFS Node

This repository contains the container definition for the Spore IPFS node, running [Kubo](https://github.com/ipfs/kubo) on `ipfs.sporeproject.com`.  

## 🚀 Features
- Based on [ipfs/kubo](https://hub.docker.com/r/ipfs/kubo) v0.26.0
- Data persisted in `/data/ipfs`, surviving container restarts and rebuilds
- Storage quota configured at **10GB** (adjustable via environment variable `IPFS_STORAGE_MAX`)
- Exposes:
  - IPFS Gateway: `https://ipfs.sporeproject.com` (HTTP on port `8080`)
  - HTTP API: `http://<host>:5001` (for local access)
  - Swarm p2p port: `4001` (for peer-to-peer connections)


## 📦 Deployment

This node runs in a Docker container orchestrated by Dokku, with:
- a persistent volume mounted at `/data/ipfs`
- ports exposed for the gateway (`8080`) and HTTP API (`5001`)
- automatic TLS termination for the gateway via Let’s Encrypt

The container automatically:
✅ Initializes the IPFS repository if needed  
✅ Ensures proper API and Gateway bind addresses (`0.0.0.0`)  
✅ Removes stale lock files left by previous containers  
✅ Enforces the configured storage maximum  

## 🔄 Lifecycle

To rebuild or restart the node:
- Stop the container first
- Rebuild the image and restart it
- The `/data/ipfs` volume ensures that content and configuration are retained

## ℹ️ Notes
- Storage quota is currently set to 10GB; you can change `IPFS_STORAGE_MAX` and rebuild.
- The WebUI (on port `5001`) may not list all pinned content; use the HTTP API to query pins or fetch content.
- The node removes stale `repo.lock` files on startup to avoid rebuild failures.

## 🔗 API Examples

Add a file:
```bash
curl -F file=@hello.txt http://127.0.0.1:5001/api/v0/add
```

Check if pinned:
```bash
curl -X POST "http://127.0.0.1:5001/api/v0/pin/ls?arg=<CID>"
```

Retrieve stats:
```bash
curl -X POST "http://127.0.0.1:5001/api/v0/object/stat?arg=<CID>"
```

Gateway:
```text
https://ipfs.sporeproject.com/ipfs/<CID>
```

---

For more details on Kubo and the IPFS HTTP API, see:  
📖 [https://docs.ipfs.tech/reference/kubo/rpc/](https://docs.ipfs.tech/reference/kubo/rpc/)
