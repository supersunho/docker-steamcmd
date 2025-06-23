# 🐧 SteamCMD for ARM64 via FEX-Emu 🐧

[![Docker Hub](https://img.shields.io/docker/pulls/supersunho/steamcmd-arm64?logo=docker)](https://hub.docker.com/r/supersunho/steamcmd-arm64) 
![Platform](https://img.shields.io/badge/arch-arm64-blue)

**Community-maintained Docker image that runs the x86_64 SteamCMD client on native ARM64 hosts using FEX-Emu.  
Not affiliated with Valve.**

---

## 🚀 Why another image?
* SteamCMD is the command-line Steam client used to install and update dedicated game servers 🎮 
* Valve does **not** publish an official ARM64 container; most community images still depend on x86 hosts or Box86/Box64 
* FEX-Emu transparently translates x86_64 syscalls to ARM64, allowing SteamCMD to run with near-native performance ⚡ 

---

## 🛠️ Features
* 🏗️ Pre-built for `linux/arm64`   
* 👤 Runs as non-root `steam` user out of the box  
* 🧩 Can be used as a base image for your own game-server containers   

---

## 📦 Tags  
| Tag | Base | Notes |
|-----|------|-------|
| `latest` | `supersunho/fex-emu:ubuntu-24.04` | Rolling, rebuilt daily |

---

## ⚡ Quick Start

```bash
# Pull image
docker pull supersunho/steamcmd-arm64:latest

# Download & update a game ( eg. App 90 = HLDS )
docker run --rm -it supersunho/steamcmd-arm64 \
                    +login anonymous +app_update 90 validate +quit
```

---

## 🗄️ Persisting Data

```bash
docker volume create steam-data
docker run -it -v steam-data:/home/steam/Steam supersunho/steamcmd-arm64 \
                  +login anonymous +app_update 740 +quit
```

---

## 🖥️ Using as a Base Image

```bash
FROM supersunho/steamcmd-arm64:latest
# only CMD is needed — ENTRYPOINT already calls steamcmd.sh
CMD ["+login","anonymous","+app_update","4020","+quit"]
```

---

## ✨ Build Locally

```bash
git clone https://github.com/supersunho/steamcmd-arm64.git
docker buildx build --platform linux/arm64 -t supersunho/steamcmd-arm64 .
```

---

## 🤝 Disclaimer
This project is **community-driven** and **not endorsed by Valve**.  
Refer to Valve’s SteamCMD documentation for official guidance 

---

## 📚 References
* steamcmd/docker – community reference implementation 
* Valve Developer Wiki – SteamCMD guide  

---  
