#!/bin/bash
set -euo pipefail

sudo pacman -S --needed --noconfirm docker docker-compose

sudo groupadd docker || true
sudo usermod -aG docker $USER
