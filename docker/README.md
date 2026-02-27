# 🦞 Claw Jesus — Docker Edition

One-click OpenClaw + Ollama setup in a container.

## Quick Start

```bash
# Pull and run
docker run -d \
  -p 3000:3000 \
  -p 11434:11434 \
  -v openclaw_data:/root/.openclaw \
  -v ollama_data:/root/.ollama \
  -e OPENCLAW_LICENSE=your-license-key \
  clawjesus/claw-jesus:latest
```

## With Docker Compose (recommended)

```bash
# Download compose file
curl -O https://clawrenceisthebestboy-dev.github.io/claw-jesus/docker/docker-compose.yml

# Set your license key
export OPENCLAW_LICENSE=your-license-key

# Start
docker compose up -d
```

## Access

- **OpenClaw:** http://localhost:3000
- **Ollama API:** http://localhost:11434

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `OPENCLAW_LICENSE` | required | Your Claw Jesus license key |
| `OLLAMA_MODEL` | `llama3.2` | Model to pull on first run |

## Requires a license key
Get one at **clawjesus.ai** — $14.99/month
