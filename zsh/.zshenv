export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export HOMEBREW_PREFIX="/opt/homebrew"
export NVM_DIR="$HOME/.nvm"
export BUN_INSTALL="$HOME/.bun"
export GOPATH="$HOME/go"

typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$BUN_INSTALL/bin"
  "$HOME/.cargo/bin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "/usr/local/go/bin"
  "$GOPATH/bin"
  $path
)
export PATH
