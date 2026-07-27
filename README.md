# dotfiles-work

Work-safe personal configuration. This repo is public, so it holds only
config that is true on every machine. Machine-specific things (aliases,
hosts, credentials, work-only paths) stay in each machine's own untracked
`~/.zshrc`.

This repo currently includes:

- Neovim config in `nvim/.config/nvim/`
- Shared zsh completion config in `zsh/completion.zsh`

## Install

```sh
git clone https://github.com/seangartland/dotfiles-work.git ~/dotfiles-work
cd ~/dotfiles-work && ./install.sh
```

`install.sh` symlinks the Neovim config and installs the zsh completion
plugins via Homebrew. Then add this line to your `~/.zshrc` once:

```sh
[ -f "$HOME/dotfiles-work/zsh/completion.zsh" ] && . "$HOME/dotfiles-work/zsh/completion.zsh"
```

Reload with `exec zsh`.

### Manual equivalent

```sh
mkdir -p ~/.config
ln -sfn "$PWD/nvim/.config/nvim" ~/.config/nvim
brew install fzf-tab zsh-autosuggestions zsh-syntax-highlighting
```

## Notes

- `~/.zshrc` is deliberately not tracked. It sources `zsh/completion.zsh`
  instead, so per-machine config never lands in a public repo.
- `zsh/completion.zsh` no-ops cleanly if Homebrew or the plugins are absent.
- `compinit` may warn about insecure directories on a fresh Homebrew install.
  Run `compaudit` and `chmod g-w` the paths it lists rather than using
  `compinit -u`.
- `lazy-lock.json` is included so plugin versions stay pinned.
- Plugin code is not versioned here; `lazy.nvim` will install it on first launch.
