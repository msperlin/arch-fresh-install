#!/bin/bash
set -euo pipefail

echo "  - Installing Google Chrome"

# Import Google's Linux signing key to prevent PPG verification prompts/failures
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --import -

# Install Chrome and MS Fonts non-interactively
yay -S --noconfirm --answerdiff=None --answerclean=None --answeredit=None google-chrome ttf-ms-fonts

