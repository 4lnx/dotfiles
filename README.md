# ⚡️ Dotfiles

> A complete, automated configuration system for a modern development environment.

![MacOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Zsh](https://img.shields.io/badge/zsh-%23F7B93E.svg?style=for-the-badge&logo=zsh&logoColor=white)
![Tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=for-the-badge&logo=neovim&logoColor=white)
![Stow](https://img.shields.io/badge/GNU%20Stow-C03036?style=for-the-badge&logo=gnu&logoColor=white)

![Dotfiles Screenshot](./images/dotfiles_screenshot.png)

## ✨ Overview

Optimized dotfiles following **XDG standards** and managed by **GNU Stow**. Designed for speed, aesthetics, and easy maintenance.

- **🚀 Automated Bootstrap**: One-command installation.
- **🎨 Catppuccin Theme**: Consistent aesthetics across all tools.
- **🔧 Modular**: Organized by component (Zsh, Tmux, Neovim, etc.).

## 🛠️ The Stack

| Category | Tools |
|----------|-------|
| **Core** | `zsh`, `oh-my-zsh`, `starship`, `stow` |
| **Terminal** | `ghostty`, `tmux`, `eza`, `fzf` |
| **Editor** | `neovim` (LazyVim base) |
| **Dev** | `git`, `ssh`, `podman`, `mise` |

## 🚀 Quick Start

```bash
# 1. Clone
git clone https://github.com/4lnx/dotfiles ~/dotfiles
cd ~/dotfiles

# 2. Bootstrap (Installs deps & links files)
./bootstrap.sh
```

## � Structure

```tree
dotfiles/
├── bootstrap.sh       # Main installer
├── zsh/               # Shell config
├── tmux/              # Multiplexer config
├── nvim/              # Neovim config
└── scripts/           # OS-specific scripts
```

## ⚙️ Management

Managed via **GNU Stow**. Symlinks are created from the dotfiles directory to your home directory.

```bash
stow .        # Install all
stow zsh      # Install only zsh
stow -D zsh   # Uninstall zsh
```

---

<div align="center">
  <sub>Built for performance and visual excellence.</sub>
</div>
