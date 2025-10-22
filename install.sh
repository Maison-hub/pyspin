#!/usr/bin/env bash
set -e

REPO="https://github.com/maison-hub/pyspin/releases/latest/download"

case "$(uname -s)" in
  Linux*)  FILE="pyspin-linux" ;;
  Darwin*) FILE="pyspin-macos" ;;
  *) echo "Unsupported OS"; exit 1 ;;
esac

echo "📦 Installing Pyspin..."
curl -sSL "$REPO/$FILE" -o /usr/local/bin/pyspin
chmod +x /usr/local/bin/pyspin
echo "✅ Pyspin installed! Type 'pyspin' to get started."