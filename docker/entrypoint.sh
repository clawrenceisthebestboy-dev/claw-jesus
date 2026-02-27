#!/bin/bash
set -e

echo ""
echo "  🦞 Claw Jesus — Docker Edition"
echo "  ================================"
echo "  Your AI setup savior, now in a container."
echo ""

# Start Ollama in background
echo "🚀 Starting Ollama..."
ollama serve &
OLLAMA_PID=$!
sleep 3

# Pull default model if specified
if [ -n "$OLLAMA_MODEL" ]; then
    echo "📦 Pulling model: $OLLAMA_MODEL"
    ollama pull "$OLLAMA_MODEL"
fi

# Start OpenClaw gateway
echo "🚀 Starting OpenClaw gateway..."
openclaw gateway start

echo ""
echo "✅ Claw Jesus is running!"
echo "   OpenClaw: http://localhost:3000"
echo "   Ollama:   http://localhost:11434"
echo ""

# Keep container alive
wait $OLLAMA_PID
