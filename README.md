# Tinygemma
Tiny gemma server for llmzmcp capstone to avoid api costs. Model is run with CPU only

- Build the image `docker build -t tinygemma .`
- RUn the container `docker run -p 11434:11434 -t tinygemma`

Create a railway service and expose the endpoint for fastapi