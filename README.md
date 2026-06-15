# Dotfiles

> Automated configuration for a modern development environment. One command bootstrap.

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![MacOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%23F7B93E.svg?style=for-the-badge&logo=zsh&logoColor=white)
![Tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=for-the-badge&logo=neovim&logoColor=white)
![LazyVim](https://img.shields.io/badge/💤-LazyVim-2E3440?style=for-the-badge)
![Stow](https://img.shields.io/badge/GNU%20Stow-C03036?style=for-the-badge&logo=gnu&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-2a2a2a?style=for-the-badge)

![Dotfiles Screenshot](./images/dotfiles_screenshot.png)

## Features

- **Full Desktop Environment** — Hyprland with Waybar status bar, Rofi launcher, and SwayNC notifications
- **Smart Package Management** — detects your OS (Arch, macOS, Ubuntu) and installs everything automatically, including AUR packages via yay
- **Modern Shell** — Zsh + Starship prompt + Oh My Zsh + Tmux with TPM plugins
- **Neovim** — LazyVim-based editor with LSP, formatters, and a curated plugin set
- **XDG Compliant** — all configs neatly organized under `~/.config/`
- **Idempotent** — safe to re-run the bootstrap as many times as you want

## What It Configures

| Category     | Tools                                                           |
| ------------ | --------------------------------------------------------------- |
| **Desktop**  | `hyprland`, `hyprpaper`, `hyprlock`, `waybar`, `rofi`, `swaync` |
| **Shell**    | `zsh`, `oh-my-zsh`, `starship`, `eza`, `fzf`, `fd`              |
| **Terminal** | `ghostty`, `tmux` (TPM)                                         |
| **Editor**   | `neovim` (LazyVim)                                              |
| **Dev**      | `git`, `ssh`, `docker`, `mise`, `lazygit`, `lazydocker`         |
| **Apps**     | `dolphin`, `keepassxc`, `obsidian`, `brave`, `discord`, `steam` |

## Quick Start

```bash
git clone https://github.com/4lnx/dotfiles ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

The bootstrap detects your OS, installs required packages, links all config files
via GNU Stow installs Oh My Zsh, Tmux TPM plugins,
the Nerd Font, and sets Zsh as your default shell.

## Structure

```
dotfiles/
├── bootstrap.sh          # Entry point — install + link everything
├── scripts/
│   ├── arch-app.sh       # Arch Linux (pacman + yay/AUR)
│   ├── osx-app.sh        # macOS (Homebrew)
│   └── ubuntu-app.sh     # Ubuntu (apt)
├── hypr/                 # Hyprland compositor config
├── waybar/               # Status bar
├── swaync/               # Notification center
├── rofi/                 # App launcher & utility scripts
├── ghostty/              # Terminal emulator
├── zsh/                  # Shell
├── tmux/                 # Terminal multiplexer
├── nvim/                 # Neovim editor
├── ssh/                  # SSH client config
├── git/                  # Git config
├── starship/             # Prompt theme
└── images/               # Screenshots
```

## OS Support

| OS         | Package Manager | AUR Support |
| ---------- | --------------- | ----------- |
| Arch Linux | pacman + yay    | ✅          |
| macOS      | Homebrew        | N/A         |
| Ubuntu     | apt             | N/A         |

## Customizing

Each directory under `dotfiles/` is a standalone stow package. Add or remove directories freely — the bootstrap will pick them up.

```bash
stow zsh      # Link only zsh config
stow -D zsh   # Unlink zsh config
```
