

```
ubuntu-ssh-docker/
├── Dockerfile
└── setup.sh
```


🔓 [Optional] Automatically Add Your Public Key
 
To add your macOS public key automatically, insert this before the final echo in setup.sh:

```
PUB_KEY=$(cat ~/.ssh/id_rsa.pub)

echo "🔐 Copying your public key into the container..."
docker exec -u root $CONTAINER_NAME bash -c "
    mkdir -p /root/.ssh && \
    echo \"$PUB_KEY\" >> /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys
"
```

```
chmod +x setup.sh
./setup.sh

```


