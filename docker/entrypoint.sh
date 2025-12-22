#!/bin/bash
set -e

ARCH="${TARGETARCH:-amd64}"

if [ "$ARCH" = "arm64" ]; then
  exec FEXBash /home/steam/steamcmd/steamcmd.sh "$@"
else
  exec /home/steam/steamcmd/steamcmd.sh "$@"
fi
