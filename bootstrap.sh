#!/usr/bin/env bash
set -euo pipefail

handle_err() {
  echo "❌ Error on line $1"
  exit 1
}
trap 'handle_err $LINENO' ERR

echo "🚀 Bootstrapping dotfiles..."

# ------------------------------------------------------------
# Detect OS
# ------------------------------------------------------------
if [[ "$(uname)" == "Darwin" ]]; then
  OS_TYPE="macos"

elif [[ "$(uname)" == "Linux" ]]; then
  if [[ -r /etc/os-release ]]; then
    source /etc/os-release
    OS_TYPE="$ID"
  else
    OS_TYPE="linux"
  fi

else
  echo "❌ Unsupported OS"
  exit 1
fi

echo "🖥️ OS detected: $OS_TYPE"
# ------------------------------------------------------------
# XDG Base Directories (KISS)
# ------------------------------------------------------------
mkdir -p \
  "$HOME/.config" \
  "$HOME/.local/bin" \
  "$HOME/.local/share" \
  "$HOME/.cache" \
  "$HOME/.local/state" \
  "$HOME/.ssh"

chmod 700 "$HOME/.ssh"

# ------------------------------------------------------------
# Packages
# ------------------------------------------------------------
echo "📦 Installing base packages..."

if [[ "$OS_TYPE" == "macos" ]]; then
  ./scripts/osx-app.sh
fi

if [[ "$OS_TYPE" == "arch" ]]; then
  ./scripts/arch-app.sh
fi

if [[ "$OS_TYPE" == "ubuntu" ]]; then
  ./scripts/ubuntu-app.sh
fi

# ------------------------------------------------------------
# Backup conflicting targets before stow
# ------------------------------------------------------------
STOW_TARGET="$HOME/.config"
DOTDIR="$(cd "$(dirname "$0")" && pwd)"

for pkg in "$DOTDIR"/*/; do
  pkg_name="$(basename "$pkg")"
  case "$pkg_name" in
  .git | scripts | images) continue ;;
  esac
  target="$STOW_TARGET/$pkg_name"
  if [[ -e "$target" || -L "$target" ]]; then
    if [[ -L "$target" ]] && [[ "$(readlink "$target")" != /* ]]; then
      continue
    fi
    backup="${target}.backup"
    echo "📦 Backing up $target to $backup"
    mv "$target" "$backup"
  fi
done

# ------------------------------------------------------------
# Stow dotfiles (FIRST!)
# ------------------------------------------------------------
echo "🔗 Linking dotfiles with stow..."

cd "$DOTDIR"

stow --restow .

# ------------------------------------------------------------
# Link configuration files
# ------------------------------------------------------------

dotfiles=(
  "$HOME/.config/zsh/zshrc:$HOME/.zshrc"
  "$HOME/.config/zsh/zprofile:$HOME/.zprofile"
  "$HOME/.config/tmux/tmux.conf:$HOME/.tmux.conf"
  "$HOME/.config/git/gitconfig:$HOME/.gitconfig"
  "$HOME/.config/ssh/config:$HOME/.ssh/config"
)

for entry in "${dotfiles[@]}"; do
  src="${entry%%:*}"
  dst="${entry#*:}"

  if [[ ! -e "$src" ]]; then
    echo "⚠️  Source $src not found, skipping $dst"
    continue
  fi

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    echo "📦 Backing up $dst to ${dst}-backup"
    mv "$dst" "${dst}-backup"
  fi

  echo "🔗 Linking $src -> $dst"
  ln -sf "$src" "$dst"
done

# Ensure correct permissions (SSH is picky about this)
if [[ -e "$HOME/.ssh/config" ]]; then
  chmod 600 "$HOME/.ssh/config"
fi

# ------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "🐚 Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ------------------------------------------------------------
# TPM (Tmux Plugin Manager)
# ------------------------------------------------------------
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  echo "🧩 Installing tmux TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# ------------------------------------------------------------
# Nerd Font – SourceCodePro NF
# ------------------------------------------------------------
install_source_code_pro_font() {
  if [[ "$OS_TYPE" == "macos" ]]; then
    FONT_DIR="$HOME/Library/Fonts"
  else
    FONT_DIR="$HOME/.local/share/fonts"
  fi

  if ls "$FONT_DIR" | grep -qi "saucecode\|sourcecodepro" 2>/dev/null; then
    echo "🔤 SourceCodePro Nerd Font already installed, skipping"
    return
  fi

  echo "🔤 Installing SourceCodePro Nerd Font..."

  mkdir -p "$FONT_DIR"

  TMP_ZIP="/tmp/SourceCodePro.zip"

  curl -fLo "$TMP_ZIP" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/SourceCodePro.zip"

  unzip -o "$TMP_ZIP" -d "$FONT_DIR"
  rm -f "$TMP_ZIP"

  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -fv >/dev/null 2>&1 || true
  fi

  echo "🔤 Nerd Font installed in $FONT_DIR"
}

install_source_code_pro_font

# ------------------------------------------------------------
# Default shell → zsh
# ------------------------------------------------------------
if command -v zsh >/dev/null && [[ "$SHELL" != "$(command -v zsh)" ]]; then
  echo "🐚 Setting zsh as default shell"
  chsh -s "$(command -v zsh)" || true
fi

echo ""
echo "✅ Bootstrap completed successfully"
echo "➡️ Restart your terminal or run: exec zsh"
