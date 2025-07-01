# Spore IPFS Node

This repository contains a Docker-based deployment of a public [IPFS](https://ipfs.tech/) node used by the [Spore Project](https://sporeproject.com). It is designed for use with [Dokku](https://dokku.com/) but can be run anywhere with Docker support.

The node acts as decentralized symbolic infrastructure — preserving cultural artifacts, symbols, and ideas.

---

## Features

- Runs the latest [go-ipfs](https://github.com/ipfs/go-ipfs) release
- Automatically configures a storage cap using `IPFS_STORAGE_MAX` env variable
- Dokku-compatible with persistent volume support
- Lightweight and production-ready

---

## 📦 Environment Variables

| Variable            | Description                                     | Default |
|---------------------|-------------------------------------------------|---------|
| `IPFS_STORAGE_MAX`  | Max storage usage (e.g. `10GB`, `20GB`)         | 10GB    |

Set this via:

```
dokku config:set spore-ipfs IPFS_STORAGE_MAX=10GB
```

---

## Deployment (via Dokku)

### Step 1: Create and Configure

```
dokku apps:create spore-ipfs
dokku domains:add spore-ipfs ipfs.sporeproject.com

# Create volume for persistence
mkdir -p /var/lib/dokku/data/storage/spore-ipfs
dokku storage:mount spore-ipfs /var/lib/dokku/data/storage/spore-ipfs:/data/ipfs
```

### Step 2: Push the Repo

```
dokku git:sync --build 

```

### Step 3: Configure Storage (Optional)

```
dokku config:set spore-ipfs IPFS_STORAGE_MAX=20GB
```

---

## 🌐 Access

Once deployed, your IPFS gateway will be accessible at:

```
https://ipfs.example.com/ipfs/<CID>
```

For example:

```
https://ipfs.example.com/ipfs/QmExample1234...
```

---

## 💡 Tips

- Use `spore-api` or any backend to POST files to `http://spore-ipfs:5001/api/v0/add`
- For high availability, consider pinning via IPFS Cluster in the future
- Keep this container separated from public-facing apps (e.g. frontend) using Docker/Dokku network isolation

---

## 🔐 Security Notes

- This repo includes no secrets or production domains
- All configuration is handled via environment variables
- Gateway port (8080) can be routed through HTTPS using Dokku + Let's Encrypt

---

## 📜 License

MIT — feel free to fork, modify, or build upon it.

---

> _“The symbol spreads. The forest remembers.” — Spore Project_
