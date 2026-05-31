#!/bin/bash
set -euo pipefail

# === Omarchy dotfiles bootstrap ===
# Clonás el repo, corrés esto, y tenés todo el setup.

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Instalando stow..."
if ! command -v stow &>/dev/null; then
  sudo pacman -S --noconfirm stow
fi

echo "==> Creando symlinks con stow..."
cd "$REPO_DIR"
stow -v -t "$HOME" home

echo "==> Configurando backgrounds..."
mkdir -p "$HOME/.config/omarchy/backgrounds"
if [[ -d "$HOME/Pictures/wallpapers" ]]; then
  ln -snf "$HOME/Pictures/wallpapers" "$HOME/.config/omarchy/backgrounds/oldwordl"
  echo "  -> Symlink a ~/Pictures/wallpapers creado."
else
  echo "  -> ~/Pictures/wallpapers no existe. Los backgrounds usaran color solido."
  echo "     Crea el directorio o ajusta el symlink manualmente:"
  echo "     ln -s /ruta/a/tus/wallpapers ~/.config/omarchy/backgrounds/oldwordl"
fi

echo ""
echo "✅ Dotfiles instalados."
echo "   Aplica el theme: omarchy theme set \"Oldwordl\""
echo "   Sincroniza wallpapers: omarchy theme bg next"
