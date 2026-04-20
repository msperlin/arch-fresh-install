#!/bin/bash
set -euo pipefail

# --- Main Execution ---
arch_file="arch-packages.txt"

# initial steps
# make all scripts executable
chmod +x scripts/*.sh

update_system() {
    sudo pacman -Syu --noconfirm
    if command -v yay &> /dev/null; then
        yay -Sua --noconfirm
    fi
}

install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "yay not found. Installing..."
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay
    fi
}

install_packages() {
    yay -S --needed --noconfirm - < "$arch_file"
}

cleanup() {
    yay -Yc --noconfirm
    yay -Sc --noconfirm
}


# Check for whiptail (provided by libnewt in Arch)
if ! command -v whiptail &> /dev/null; then
    echo "whiptail not found. Installing..."
    sudo pacman -S --needed --noconfirm libnewt
fi

# Ensure yay is installed
install_yay

echo "=== ARCH Setup Script ==="

CHOICES=$(whiptail --title "Arch Setup" --checklist \
"Select components to install (Space to select, Enter to confirm):" 22 78 14 \
"UPDATE" "Update and Upgrade System" ON \
"PAC" "Install packages in $arch_file" OFF \
"UTILS" "Install utils (gh,topgrade, ..)" OFF \
"STEAM" "Install Steam" OFF \
"CHROME" "Install Google Chrome" OFF \
"TEXLIVE" "Install texlive packages" OFF \
"R_PKG" "Install R-related packages" OFF \
"PYTHON" "Install Python related packages" OFF \
"VSCODE" "Install vscode" OFF \
"GIT" "Configure git username and email" OFF \
"DOCKER" "Install Docker" OFF \
"INSYNC" "Install Insync (Google Drive client)" OFF \
"CLEANUP" "Run System Cleanup" OFF \
3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then
    for CHOICE in $CHOICES; do
        case "$CHOICE" in
            '"UPDATE"') update_system ;;
            '"PAC"') install_packages ;;
            '"UTILS"') ./scripts/install-utils.sh ;;
            '"STEAM"') ./scripts/install-steam.sh ;;
            '"CHROME"') ./scripts/install_Google-Chrome.sh ;;
            '"TEXLIVE"') ./scripts/install-texlive.sh ;;
            '"R_PKG"') ./scripts/install-R-related.sh ;;
            '"PYTHON"') ./scripts/install-python-related.sh ;;
            '"VSCODE"') ./scripts/install-vscode.sh ;;
            '"GIT"') ./scripts/configure-git.sh ;;
            '"DOCKER"') ./scripts/install-config-docker.sh ;;
            '"INSYNC"') ./scripts/install-insync.sh ;;
            '"CLEANUP"') cleanup ;;
        esac
    done
    echo "=== Setup Complete! ==="
    echo "Please restart your session to apply major changes."
else
    echo "Setup cancelled."
fi
