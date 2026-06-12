#!/usr/bin/env bash
set -e

echo "🍺 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🍺 Installing dependencies..."
sudo apt install -y \
  curl \
  wget \
  git \
  unzip \
  gnupg \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  build-essential

echo "🍺 Installing Applications..."

sudo apt install -y \
  zsh \
  git \
  tmux \
  stow \
  neovim \
  ghostty \
  openssh-client \
  docker.io \
  unzip \
  fzf \
  gnupg \
  pinentry-curses \
  tree \
  ipcalc

echo "🍺 Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "🍺 Installing eza..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

echo "🍺 Installing mise..."
curl https://mise.run | sh

echo "🍺 Installing talosctl..."
curl -sSfL https://raw.githubusercontent.com/siderolabs/talos/main/install.sh | sh

echo "🍺 Done!"
