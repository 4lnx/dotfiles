#!/usr/bin/env bash
set -e

echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "🍺 Installing Applications..."

brew install \
	git \
	tmux \
	stow \
	neovim \
	ghostty \
	starship \
	openssh \
	docker \
	unzip \
	eza \
	fzf \
	gnupg \
	pinentry \
	pinentry-mac \
	talosctl \
	tree \
	ipcalc \
	mise

echo "🍺 Done!"
