#!/usr/bin/env bash
# install.sh — Automatic installer for agy-top
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
TARGET="$BIN_DIR/agy-top"

echo "🚀 Встановлення agy-top..."

# 1. Check Python 3
if ! command -v python3 >/dev/null 2>&1; then
  echo "❌ Помилка: python3 не знайдено. Встановіть Python 3 (sudo apt install python3 python3-pip)."
  exit 1
fi

# 2. Install Python dependencies (textual, rich)
echo "📦 Перевірка та встановлення залежностей Python (textual, rich)..."
if ! python3 -c "import textual, rich" >/dev/null 2>&1; then
  if python3 -m pip install --user -r "$REPO_DIR/requirements.txt" 2>/dev/null; then
    echo "✅ Залежності встановлено через pip --user"
  elif python3 -m pip install --user --break-system-packages -r "$REPO_DIR/requirements.txt" 2>/dev/null; then
    echo "✅ Залежності встановлено через pip --user --break-system-packages"
  else
    echo "⚠️ Не вдалося встановити через pip напряму. Спробуйте: sudo apt install python3-pip && pip3 install --user --break-system-packages textual rich"
    exit 1
  fi
else
  echo "✅ Залежності (textual, rich) вже встановлені."
fi

# 3. Copy executable to ~/.local/bin/agy-top
mkdir -p "$BIN_DIR"
cp "$REPO_DIR/agy-top" "$TARGET"
chmod +x "$TARGET"
echo "✅ Скопійовано виконуваний файл у $TARGET"

# 4. Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [[ -f "$rc" ]] && ! grep -q '.local/bin' "$rc"; then
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc"
      echo "➕ Додано ~/.local/bin у PATH ($rc)"
    fi
  done
  echo "ℹ️ Перезапустіть термінал або виконайте: source ~/.bashrc"
fi

echo ""
echo "🎉 Встановлення завершено! Запускайте з будь-якого терміналу командою:"
echo "   agy-top"
