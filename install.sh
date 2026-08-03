#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

mkdir -p "$HOME/.config"
ln -sfn "$ROOT/nvim/.config/nvim" "$HOME/.config/nvim"
printf '%s\n' "Linked Neovim config to $HOME/.config/nvim"

mkdir -p "$HOME/.config/ghostty"
ln -sfn "$ROOT/ghostty/.config/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"
printf '%s\n' "Linked Ghostty config to $HOME/.config/ghostty/config.ghostty"

if command -v brew >/dev/null 2>&1; then
  brew install fzf-tab zsh-autosuggestions zsh-syntax-highlighting
else
  printf '%s\n' "Homebrew not found; skipping zsh completion plugins."
fi

printf '\n%s\n' "Add this line to your ~/.zshrc (once):"
printf '%s\n' "  [ -f \"$ROOT/zsh/completion.zsh\" ] && . \"$ROOT/zsh/completion.zsh\""
