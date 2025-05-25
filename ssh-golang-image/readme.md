
# SSH + Golang + Python Docker Image

This project builds a Docker image with:

- ✅ OpenSSH server (port configurable)
- ✅ Golang 1.21 (modularized under `/golang`)
- ✅ Python 3 (modularized under `/python`)
- ✅ Internal CA certs (e.g., Zscaler)


This image sets up a Golang environment with OpenSSH access and custom certificate injection (e.g. Zscaler).

## 🔧 Directory Structure

✅ Directory Structure

```
ssh-golang-image/
├── certs/
│   └── ROOT_CERTS.tar.gz         # Your custom cert bundle (Zscaler, etc.)
├── Dockerfile
├── .env                          # Configuration variables
└── README.md
```

## ⚙️ Setup

### 1. Prepare certs

Place your root certificates as `.crt` files inside a tarball:

```bash
mkdir certs
tar -czvf certs/ROOT_CERTS.tar.gz *.crt
```

### 2. Configure .env
Edit the .env file with proxy settings and SSH credentials.

### 3. Build the Docker Image

```
# Load .env into shell and pass as build args
set -o allexport; source .env; set +o allexport

docker build \
  --build-arg HTTP_PROXY \
  --build-arg HTTPS_PROXY \
  --build-arg FTP_PROXY \
  --build-arg NO_PROXY \
  --build-arg GOPROXY \
  --build-arg SSH_USER \
  --build-arg SSH_PASSWORD \
  -t ssh-golang-image .

```

### 4. Run the Container
```
docker run -d -p 2222:22 --name sship ssh-golang-image
```

```
# Check container IP and details
docker inspect sship | grep IPAddress
```

### 5. Connect via SSH
```
ssh saduser@localhost -p 2222
```

### 🧪 Test Commands
Inside container:

# Run Golang app
```
cd /app/golang && go run main.go
```
# Run Python script
```
cd /app/python && python3 script.py
```

### 🚨 Notes
This setup is for internal/testing environments.
Use SSH keys and proper secrets management in production.


✅ Inject Custom Root Certificates (e.g., Zscaler, internal CA)
Many corporate environments (like behind Zscaler) intercept SSL traffic and require adding custom CA root certificates to your containers to allow secure HTTPS access (e.g., curl, go get, apt).


🔐 go.sum Protects you from supply-chain attacks and unexpected changes.
Required by `go build`, `go mod tidy`, and other tools to ensure safety.

💡 Tip: Never edit go.sum manually. It's automatically maintained by Go tooling (go get, go mod tidy, etc.).
