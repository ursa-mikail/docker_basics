
# Stage 1: Fetch and extract custom root certs
FROM curlimages/curl:latest AS certs

# 1. COPY and Extract Certs
# Unpacks your custom certs into /tmp/certs in the intermediate build stage.
# Certs may be many files — .crt or .pem. A single archive simplifies copy and versioning.

COPY certs/ROOT_CERTS.tar.gz /tmp/
RUN mkdir -p /tmp/certs && \
    tar -xzvf /tmp/ROOT_CERTS.tar.gz -C /tmp/certs

# Stage 2: Final Golang + SSH image
FROM golang:1.21

# Accept build arguments from .env
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG FTP_PROXY
ARG NO_PROXY
ARG GOPROXY
ARG SSH_USER
ARG SSH_PASSWORD

# Set proxy and Go proxy
ENV http_proxy=$HTTP_PROXY \
    https_proxy=$HTTPS_PROXY \
    ftp_proxy=$FTP_PROXY \
    no_proxy=$NO_PROXY \
    GOPROXY=$GOPROXY

# Install CA certs and OpenSSH
RUN apt-get update && \
    apt-get install -y ca-certificates openssh-server && \
    update-ca-certificates && \
    mkdir -p /app /var/run/sshd

# Copy certs from previous stage
# Copy Extracted .crt Files into the Final Image
# --from=certs: a multi-stage build. The certs stage is used only to extract and prepare certs.
# importing just the .crt files into the final Golang-based image.
# /usr/local/share/ca-certificates/: conventional location for extra CA certs in Debian-based systems.
# update-ca-certificates: Make the certs effective system-wide. regenerates the system’s certificate store (e.g., /etc/ssl/certs/ca-certificates.crt), so that tools like curl, apt, and golang can trust those custom certs.
# 💡 Alternative: skip the tarball to copy individual .crt files directly: `COPY certs/*.crt /usr/local/share/ca-certificates/`

COPY --from=certs /tmp/certs/*.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Create SSH user
RUN useradd -m -s /bin/bash ${SSH_USER} && \
    echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

# Enable root login via SSH (for dev/test only)
RUN sed -i 's/^#*PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
WORKDIR /app
CMD ["/usr/sbin/sshd", "-D"]

