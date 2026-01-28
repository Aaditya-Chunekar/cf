#!/usr/bin/env bash
set -e

REPO_RAW="https://raw.githubusercontent.com/Aaditya-Chunekar/cf/main"
INSTALL_DIR="$HOME/.local/bin"
BIN_NAME="cf"

echo "Installing cf..."

mkdir -p "$INSTALL_DIR"

curl -fsSL "$REPO_RAW/cf.sh" -o "$INSTALL_DIR/$BIN_NAME"
chmod +x "$INSTALL_DIR/$BIN_NAME"

# Ensure ~/.local/bin is in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$INSTALL_DIR"; then
  SHELL_NAME="$(basename "$SHELL")"

  case "$SHELL_NAME" in
    bash)
      PROFILE="$HOME/.bashrc"
      ;;
    zsh)
      PROFILE="$HOME/.zshrc"
      ;;
    *)
      PROFILE="$HOME/.profile"
      ;;
  esac

  echo "" >> "$PROFILE"
  echo '# Added by cf installer' >> "$PROFILE"
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$PROFILE"

  echo "Added ~/.local/bin to PATH in $PROFILE"
  echo "Restart your shell or run: source $PROFILE"
fi

echo "Installed successfully!"
echo "Run: cf"
