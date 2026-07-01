#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

mkdir -p "$HOME/.config"
ln -sfn "$ROOT/nvim/.config/nvim" "$HOME/.config/nvim"

printf '%s\n' "Linked Neovim config to $HOME/.config/nvim"
