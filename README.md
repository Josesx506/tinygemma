# Tinygemma
Tiny gemma server for llmzmcp capstone to avoid api costs. Model is run with CPU only

- Build the image `docker build -t tinygemma .`
- RUn the container `docker run -p 11434:11434 -t tinygemma`

Create a railway service and expose the endpoint for fastapi. Query the api with
```bash
curl https://tinygemma-production.up.railway.app/api/chat -d '{
  "model": "gemma3:1b",
  "messages": [
    { "role": "user", "content": "why is the sky blue?" }
  ],
  "stream": false
}'
```


### Powerlabs IaC workshop
Installing terraform
```bash
# Mac
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -v
```

1. Create the configuration file e.g. _workshop.tf_.
2. Install related resources to your config file with `terraform init` in terminal
3. You can use `output` code blocks to log variables etc. Run the workflow with `terraform plan` to see the changes or errors
4. Apply the changes with `terraform apply` to deploy your changes to cloud