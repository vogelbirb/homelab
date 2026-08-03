#!/bin/sh
cd /srv/vogelbirb-homepage
sudo -u matheus git pull
docker run -u "$(id -u):$(id -g)" -v $(pwd):/app --workdir /app ghcr.io/getzola/zola:v0.22.1 build
