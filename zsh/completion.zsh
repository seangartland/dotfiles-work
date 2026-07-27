# Shared zsh completion config. Sourced from ~/.zshrc on each machine.
# Requires: brew install fzf-tab zsh-autosuggestions zsh-syntax-highlighting

# Enable zsh completion system
autoload -Uz compinit
compinit

# Better completion behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'

# Make file/path completion friendlier
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' accept-exact-dirs true

# Complete hidden files only when pattern starts with .
zstyle ':completion:*' special-dirs true

# Show a menu immediately on ambiguous completion
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' group-name ''

# Use arrow keys / menu selection for completion
zmodload zsh/complist
bindkey -M menuselect '^[[D' backward-char
bindkey -M menuselect '^[[C' forward-char

# Make autosuggestions try real completion first, then history.
# Helps with commands like: open <local-file>
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# Plugins, if installed. Order matters: syntax-highlighting must load last.
if command -v brew >/dev/null 2>&1; then
  _brew_prefix="$(brew --prefix)"
  for _p in \
    "$_brew_prefix/share/fzf-tab/fzf-tab.plugin.zsh" \
    "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
    "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  do
    [ -f "$_p" ] && . "$_p"
  done
  unset _brew_prefix _p
fi
