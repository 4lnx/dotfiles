#!/usr/bin/env bash
set -e
echo "🍺 Updating..."

sudo pacman -Syyu --noconfirm

echo "🍺 Installing Applications..."

sudo pacman -S  --noconfirm git \
	tmux \
	stow \
	neovim \
	ghostty \
	starship \
	openssh \
	podman \
	unzip \
	eza \
	fzf \
	gnupg \
	pinentry \
	talosctl \
	tree \
	ipcalc \
	mise

echo "🍺 Install AUR Helper..."

UUID=$(uuidgen)
mkdir -p /tmp/$UUID/aur
cd /tmp/$UUID/aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd
rm -rf /tmp/$UUID

echo "🍺 Done!"
