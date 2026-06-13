#!/usr/bin/env bash
set -euo pipefail

handle_err() {
  echo "❌ Error on line $1"
  exit 1
}
trap 'handle_err $LINENO' ERR

echo "🍺 Updating..."
sudo pacman -Syyu --noconfirm

# ------------------------------------------------------------
# Pacman packages
# ------------------------------------------------------------
PACMAN_PACKAGES=(
  # Core / bootstrap
  base-devel git wget unzip 7zip unarchiver
  zsh tmux stow neovim ghostty starship openssh docker docker-compose
  eza fzf fd gnupg pinentry tree ipcalc fastfetch usage

  # Hyprland ecosystem
  hyprland hypridle hyprlock hyprcursor hyprpaper hyprpicker hyprlauncher

  # Desktop
  waybar rofi swaync dunst dolphin dolphin-plugins ffmpegthumbs
  kdenetwork-filesharing ark kio-admin kio-extras
  keepassxc okular obsidian veracrypt qbittorrent
  discord steam obs-studio mpv pavucontrol

  # Clipboard & media
  wl-clipboard cliphist brightnessctl

  # System tools
  btop htop imagemagick libnotify inotify-tools whois zbar
  calcurse calindori bluetui wev
  mpc alsa-utils bc git-lfs
  networkmanager nm-connection-editor network-manager-applet
  bluez bluez-utils
  wireplumber pipewire pipewire-alsa pipewire-jack pipewire-pulse
  gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly
  ffmpeg ffmpegthumbnailer

  # KDE / look & feel
  breeze breeze5 breeze-gtk papirus-icon-theme nwg-look
  kde-cli-tools archlinux-xdg-menu
  polkit-kde-agent qt5-wayland qt6-wayland
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
  xdg-user-dirs xdg-user-dirs-gtk xdg-utils

  # Virtualization
  virt-manager qemu-full libvirt dnsmasq

  # Dev
  lazygit lazydocker mise
  prettier packer markdownlint-cli2 luarocks
  mesa libva-mesa-driver libva-utils

  # Fonts
  ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-opensans noto-fonts

  # Other
  flatpak flatpak-xdg-utils sddm timeshift fish bazaar
)

echo "🍺 Installing pacman packages..."
for pkg in "${PACMAN_PACKAGES[@]}"; do
  if pacman -Qi "$pkg" &>/dev/null; then
    echo "  ✓ $pkg"
  else
    echo "  Installing $pkg..."
    sudo pacman -S --noconfirm "$pkg"
  fi
done

# ------------------------------------------------------------
# Install AUR helper (yay)
# ------------------------------------------------------------
if ! command -v yay &>/dev/null; then
  echo "🍺 Installing yay (AUR helper)..."
  BUILD_DIR="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git "$BUILD_DIR/yay"
  (cd "$BUILD_DIR/yay" && makepkg -si --noconfirm)
  rm -rf "$BUILD_DIR"
fi

# ------------------------------------------------------------
# AUR packages (via yay)
# ------------------------------------------------------------
AUR_PACKAGES=(
  hyprshot
  wlogout
  qt5ct-kde
  qt6ct-kde
  qview
  playerctl
  python-setuptools
  zscroll
  nmrs
  wireguard-gui-bin
  appflowy-bin
  terraform-ls
  brave-bin
  matugen-bin
)

echo "🍺 Installing AUR packages..."
for pkg in "${AUR_PACKAGES[@]}"; do
  if yay -Qi "$pkg" &>/dev/null; then
    echo "  ✓ $pkg"
  else
    echo "  Installing $pkg..."
    yay -S --noconfirm "$pkg"
  fi
done

echo "🍺 Done!"
