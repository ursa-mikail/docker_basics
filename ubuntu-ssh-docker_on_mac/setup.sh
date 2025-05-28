#!/bin/bash

set -e

IMAGE_NAME="ubuntu-ssh"
CONTAINER_NAME="my-ubuntu-ssh"
SSH_PORT=2222

echo "🛠 Building Docker image..."
docker build -t $IMAGE_NAME .

echo "🧹 Cleaning up existing container (if any)..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

echo "🚀 Running container with SSH access on port $SSH_PORT..."
docker run -d -p $SSH_PORT:2222 --name $CONTAINER_NAME $IMAGE_NAME

echo "⏳ Waiting for SSH to be ready..."
sleep 2

echo "✅ Container '$CONTAINER_NAME' is up and running."
echo "🔐 You can SSH using:"
echo "    ssh root@localhost -p $SSH_PORT"
echo "    (Password: root)"

