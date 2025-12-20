#!/usr/bin/env bash
set -e

echo "🚀 Bootstrapping dotfiles..."

# ------------------------------------------------------------
# Detect OS
# ------------------------------------------------------------
if [[ "$(uname)" == "Darwin" ]]; then
  OS_TYPE="macos"
  echo "🖥️ OS detected: $OS_TYPE"
else
  echo "❌ Unsupported OS"
fi

# ------------------------------------------------------------
# XDG Base Directories (KISS)
# ------------------------------------------------------------
mkdir -p \
  "$HOME/.config" \
  "$HOME/.local/bin" \
  "$HOME/.local/share" \
  "$HOME/.cache" \
  "$HOME/.local/state"

# ------------------------------------------------------------
# Packages
# ------------------------------------------------------------
echo "📦 Installing base packages..."

if [[ "$OS_TYPE" == "macos" ]]; then
  ./scripts/osx-app.sh
fi

# ------------------------------------------------------------
# Stow dotfiles (FIRST!)
# ------------------------------------------------------------
echo "🔗 Linking dotfiles with stow..."

cd "$(dirname "$0")"

stow .

# ------------------------------------------------------------
# Link configuration files
# ------------------------------------------------------------
ln -sf "$HOME/.config/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.config/zsh/zprofile" "$HOME/.zprofile"
ln -sf "$HOME/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/.config/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/.config/ssh/config" "$HOME/.ssh/config"


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
  echo "🔤 Installing SourceCodePro Nerd Font..."

  if [[ "$OS_TYPE" == "macos" ]]; then
    FONT_DIR="$HOME/Library/Fonts"
  else
    FONT_DIR="$HOME/.local/share/fonts"
  fi

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
