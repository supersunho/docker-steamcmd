ARG TARGETARCH
ARG TARGETPLATFORM

# amd64 specific stage  
FROM ubuntu:24.04 AS base-amd64
ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash steam && \
    usermod -aG sudo steam && \
    echo "steam ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/steam

USER steam
WORKDIR /home/steam/steamcmd

# Download and extract SteamCMD; do not execute it at build time
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    | tar zxvf - \
 && mkdir -p ~/.steam/sdk64/ \
 && ln -sf ../../steamcmd/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

WORKDIR /home/steam

# arm64 specific stage  
FROM supersunho/fex-emu:latest AS base-arm64
ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash steam && \
    usermod -aG sudo steam && \
    echo "steam ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/steam

USER steam
WORKDIR /home/steam/steamcmd

# Download and extract SteamCMD under FEX base image; do not run it here
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    | tar zxvf - \
 && mkdir -p ~/.steam/sdk64/ \
 && ln -sf ../../steamcmd/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

WORKDIR /home/steam

# Final stage: select by TARGETARCH value   
FROM base-${TARGETARCH} AS final

ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH}

USER root
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER steam
WORKDIR /home/steam

ENTRYPOINT ["/entrypoint.sh"]
