# Use Ollama base image
FROM ollama/ollama

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Preload model - Start ollama serve in the background, wait for it, then pull the model
RUN ollama serve & \
    until curl -s http://localhost:11434 > /dev/null; do \
        echo "Waiting for Ollama server..."; \
        sleep 1; \
    done && \
    ollama pull tinyllama && \
    pkill ollama # Optional: kill the server if you only need it for the pull


# Expose Ollama's default port
EXPOSE 11434

# Ollama runs automatically on container start
CMD ["serve"]
