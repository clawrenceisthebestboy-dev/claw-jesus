FROM node:20-slim

LABEL maintainer="Claw Jesus <clawjesus@clawjesus.ai>"
LABEL description="Claw Jesus — One-click OpenClaw + Ollama setup in Docker"

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install OpenClaw globally
RUN npm install -g openclaw

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | bash

# Create workspace
RUN mkdir -p /root/.openclaw/workspace

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose OpenClaw gateway port
EXPOSE 3000

# Default volumes
VOLUME ["/root/.openclaw", "/root/.ollama"]

ENTRYPOINT ["/entrypoint.sh"]
