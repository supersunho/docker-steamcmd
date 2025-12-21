# Multi-architecture Dockerfile for SteamCMD
# Supports both amd64 and arm64 architectures through Docker Buildx

# Use conditional base image based on target platform
FROM --platform=$TARGETPLATFORM ubuntu:24.04 AS base-amd64
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN sudo useradd -m -s /bin/bash steam && \
    sudo usermod -aG sudo steam && \
    echo "steam ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/steam

USER steam   
WORKDIR /home/steam/steamcmd

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
    && mkdir -p ~/.steam/sdk64/ \
    && ln -sf ../../steamcmd/linux64/steamclient.so ~/.steam/sdk64/

WORKDIR /home/steam
ENTRYPOINT ["/home/steam/steamcmd/steamcmd.sh"]
CMD ["+quit"]

FROM --platform=$TARGETPLATFORM supersunho/fex-emu:latest AS base-arm64
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN sudo useradd -m -s /bin/bash steam && \
    sudo usermod -aG sudo steam && \
    echo "steam ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/steam

USER steam   
WORKDIR /home/steam/steamcmd

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
    && FEXBash -c "/home/steam/steamcmd/steamcmd.sh +quit" \
    && mkdir -p ~/.steam/sdk64/ \
    && ln -sf ../../steamcmd/linux64/steamclient.so ~/.steam/sdk64/

WORKDIR /home/steam
ENTRYPOINT ["FEXBash", "/home/steam/steamcmd/steamcmd.sh"]
CMD ["+quit"]

# Select the appropriate base based on the target architecture
# This approach allows Docker Buildx to build multi-arch images correctly
FROM --platform=$TARGETPLATFORM base-${TARGETARCH}