#!/bin/bash
set -euo pipefail

yay -S --noconfirm insync insync-dolphin

# Start Insync (this will trigger the login window if not headless)
echo "Installation complete. Starting Insync..."
insync start &