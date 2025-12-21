# 🐧 SteamCMD Multi-Architecture Docker Image 🐧

[![Docker Hub](https://img.shields.io/docker/pulls/supersunho/steamcmd?logo=docker)](https://hub.docker.com/r/supersunho/steamcmd)
![Platform](https://img.shields.io/badge/arch-amd64%20%7C%20arm64-blue)

\*\*Community-maintained Docker image that runs the x86_64 SteamCMD client on multiple architectures:

-   On AMD64: Directly on native platform
-   On ARM64: Using FEX-Emu for transparent x86_64 emulation

Not affiliated with Valve.\*\*

---

## 🚀 Why this image?

-   SteamCMD is the command-line Steam client used to install and update dedicated game servers 🎮
-   Valve does **not** publish an official multi-architecture container
-   This image provides transparent support for both AMD64 and ARM64 hosts with near-native performance ⚡
-   On ARM64, FEX-Emu transparently translates x86_64 syscalls, allowing SteamCMD to run efficiently

---

## 🛠️ Features

-   🏗️ Pre-built for `linux/amd64` and `linux/arm64`
-   👤 Runs as non-root `steam` user out of the box
-   🧩 Can be used as a base image for your own game-server containers
-   🌐 Automatic architecture detection - pull the same image tag and get the right architecture

---

## 📦 Tags

| Tag             | Architecture        | Base                                                              | Notes                                    |
| --------------- | ------------------- | ----------------------------------------------------------------- | ---------------------------------------- |
| `latest`        | Multi-arch manifest | `ubuntu:24.04` (amd64), `supersunho/fex-emu:ubuntu-24.04` (arm64) | Pulls correct architecture automatically |
| `amd64`         | AMD64 only          | `ubuntu:24.04`                                                    | AMD64-specific image                     |
| `arm64`         | ARM64 only          | `supersunho/fex-emu:ubuntu-24.04`                                 | ARM64-specific image with FEX-Emu        |
| `[commit-hash]` | Multi-arch manifest | `ubuntu:24.04` (amd64), `supersunho/fex-emu:ubuntu-24.04` (arm64) | Version-specific builds                  |

---

## ⚡ Quick Start

```bash
# Pull image (automatically gets the right architecture for your host)
docker pull supersunho/steamcmd:latest

# Download & update a game ( eg. App 90 = HLDS )
docker run --rm -it supersunho/steamcmd \
                    +login anonymous +app_update 90 validate +quit

# Or pull specific architecture
docker pull supersunho/steamcmd:amd64    # For AMD64 hosts
docker pull supersunho/steamcmd:arm64    # For ARM64 hosts
```

---

## 🗄️ Persisting Data

```bash
docker volume create steam-data
docker run -it -v steam-data:/home/steam/Steam supersunho/steamcmd \
                  +login anonymous +app_update 740 +quit
```

---

## 🖥️ Using as a Base Image

```bash
FROM supersunho/steamcmd:latest
# only CMD is needed — ENTRYPOINT already calls steamcmd.sh
CMD ["+login","anonymous","+app_update","4020","+quit"]
```

---

## ✨ Build Locally

```bash
git clone https://github.com/supersunho/docker-steamcmd.git
cd docker-steamcmd

# Build for your current platform
docker buildx build --platform linux/amd64,linux/arm64 -t supersunho/steamcmd .

# Or build for a specific platform
docker buildx build --platform linux/amd64 -t supersunho/steamcmd:amd64 .
docker buildx build --platform linux/arm64 -t supersunho/steamcmd:arm64 .
```

---

## 🤝 Disclaimer

This project is **community-driven** and **not endorsed by Valve**.  
Refer to Valve’s SteamCMD documentation for official guidance

---

## 📚 References

-   steamcmd/docker – community reference implementation
-   Valve Developer Wiki – SteamCMD guide
-   FEX-Emu – x86_64 emulation for ARM64

---
