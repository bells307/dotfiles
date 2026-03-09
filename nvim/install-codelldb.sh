#!/usr/bin/env bash
set -e

CODELLDB_DIR="$HOME/.local/share/codelldb"
CODELLDB_BIN="$CODELLDB_DIR/extension/adapter/codelldb"

if [ -f "$CODELLDB_BIN" ]; then
    echo "codelldb already installed at $CODELLDB_BIN"
    exit 0
fi

ARCH=$(uname -m)
case "$ARCH" in
arm64) VSIX="codelldb-darwin-arm64.vsix" ;;
x86_64) VSIX="codelldb-darwin-x64.vsix" ;;
*)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

echo "Downloading $VSIX..."
TMP=$(mktemp /tmp/codelldb.XXXXXX).vsix
curl -fsSL "https://github.com/vadimcn/codelldb/releases/latest/download/$VSIX" -o "$TMP"

echo "Extracting..."
mkdir -p "$CODELLDB_DIR"
unzip -q "$TMP" -d "$CODELLDB_DIR"
rm "$TMP"
chmod +x "$CODELLDB_BIN"

echo "Done. codelldb installed at $CODELLDB_BIN"
