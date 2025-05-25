

# SSH-Ready Golang Docker Image

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

### 5. Connect via SSH
```
ssh saduser@localhost -p 2222
```

### 🚨 Notes
This setup is for internal/testing environments.
Use SSH keys and proper secrets management in production.


✅ Inject Custom Root Certificates (e.g., Zscaler, internal CA)
Many corporate environments (like behind Zscaler) intercept SSL traffic and require adding custom CA root certificates to your containers to allow secure HTTPS access (e.g., curl, go get, apt).



