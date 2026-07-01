# dotfiles-work

Work-safe personal configuration.

This repo currently includes:

- Neovim config in `nvim/.config/nvim/`

## Install

Create the target config directory and symlink the Neovim config:

```sh
./install.sh
```

Or link it manually:

```sh
mkdir -p ~/.config
ln -sfn "$PWD/nvim/.config/nvim" ~/.config/nvim
```

## Notes

- `lazy-lock.json` is included so plugin versions stay pinned.
- Plugin code is not versioned here; `lazy.nvim` will install it on first launch.
