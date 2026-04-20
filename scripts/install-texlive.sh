#!/bin/bash
set -euo pipefail

sudo pacman -S --needed --noconfirm \
    texlive-basic texlive-latex \
    texlive-latexextra texlive-fontsrecommended \
    texlive-mathscience texlive-pictures \
    texlive-bibtexextra texlive-xetex \
    texlive-luatex texlive-langportuguese
