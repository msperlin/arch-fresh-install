#!/bin/bash
set -euo pipefail

name_repo="arch-fresh-install"

sudo pacman -S --needed --noconfirm git

cd "/home/$USER/Downloads" || exit
rm -rf "$name_repo"

# use https for cloning (ssh doesnt work)
git clone "https://github.com/msperlin/$name_repo.git"

cd "$name_repo" || exit

bash setup-with-whiptail.sh
