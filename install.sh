#!/usr/bin/env bash
set -e

REPO="maison-hub/pyspin" # ← remplace par ton repo GitHub (ex: aro-tak/pyspin)
BINARY_NAME="pyspin"
INSTALL_DIR="/usr/local/bin"

# --- Detect OS & Arch ---
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$OS" in
  linux) TARGET="${BINARY_NAME}-linux" ;;
  darwin) TARGET="${BINARY_NAME}-macos" ;;
  *)
    echo "❌ OS non supporté : $OS"
    exit 1
    ;;
esac

# --- Check if user has write access ---
if [ ! -w "$INSTALL_DIR" ]; then
  INSTALL_DIR="$HOME/.local/bin"
  mkdir -p "$INSTALL_DIR"
  echo "ℹ️ Pas de droits sur /usr/local/bin, installation dans $INSTALL_DIR"
fi

# --- Fetch latest release URL ---
echo "📦 Téléchargement de la dernière version de $BINARY_NAME pour $OS..."
LATEST_URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest \
  | grep "browser_download_url" \
  | grep "$TARGET" \
  | cut -d '"' -f 4)

if [ -z "$LATEST_URL" ]; then
  echo "❌ Impossible de trouver le binaire pour $OS."
  exit 1
fi

# --- Download binary ---
TMP_FILE=$(mktemp)
curl -L "$LATEST_URL" -o "$TMP_FILE"

chmod +x "$TMP_FILE"
mv "$TMP_FILE" "$INSTALL_DIR/$BINARY_NAME"

# --- Add to PATH if needed ---
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo "⚙️ Ajout de $INSTALL_DIR à ton PATH..."
  echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.bashrc"
  echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.zshrc"
fi

# --- Verify installation ---
echo "✅ Installation réussie !"
echo
echo "Exécute :"
echo "   $BINARY_NAME --help"
echo
echo "Version installée :"
"$INSTALL_DIR/$BINARY_NAME" --version || echo "(Impossible de récupérer la version)"
