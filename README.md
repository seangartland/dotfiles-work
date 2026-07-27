# dotfiles-work

Work-safe personal configuration. This repo is public, so it holds only
config that is true on every machine. Machine-specific things (aliases,
hosts, credentials, work-only paths) stay in each machine's own untracked
`~/.zshrc`.

This repo currently includes:

- Neovim config in `nvim/.config/nvim/`
- Shared zsh completion config in `zsh/completion.zsh`

## Install on a new machine

Copy-paste this whole block. Requires Homebrew.

```sh
git clone https://github.com/seangartland/dotfiles-work.git ~/dotfiles-work && cd ~/dotfiles-work && ./install.sh && echo '[ -f "$HOME/dotfiles-work/zsh/completion.zsh" ] && . "$HOME/dotfiles-work/zsh/completion.zsh"' >> ~/.zshrc && exec zsh
```

Then check it worked: type `cd ` and hit Tab — directories should appear in a
selectable menu. Typing the start of a previous command should show a grey
suggestion; press the right arrow to accept it.

If `~/.config/nvim` already exists as a real directory, move it aside first,
or `ln -sfn` will nest the symlink inside it instead of replacing it:

```sh
mv ~/.config/nvim ~/.config/nvim.backup
```

### What that one-liner does

1. Clones this repo to `~/dotfiles-work`.
2. Runs `install.sh`, which symlinks `nvim/.config/nvim` to `~/.config/nvim`
   and runs `brew install fzf-tab zsh-autosuggestions zsh-syntax-highlighting`.
3. Appends the `zsh/completion.zsh` source line to `~/.zshrc` (appends only —
   an existing `~/.zshrc` is not overwritten).
4. Reloads the shell.

### Step by step

```sh
git clone https://github.com/seangartland/dotfiles-work.git ~/dotfiles-work
cd ~/dotfiles-work
./install.sh
```

Add this line to `~/.zshrc` once, then `exec zsh`:

```sh
[ -f "$HOME/dotfiles-work/zsh/completion.zsh" ] && . "$HOME/dotfiles-work/zsh/completion.zsh"
```

### Fully manual, no install.sh

```sh
mkdir -p ~/.config
ln -sfn ~/dotfiles-work/nvim/.config/nvim ~/.config/nvim
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
