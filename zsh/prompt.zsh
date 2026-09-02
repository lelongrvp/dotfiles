# ~/.config/zsh/prompt.zsh

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

# Normally exported from .zshenv; this fallback keeps the prompt themed even if
# STARSHIP_CONFIG has not been set there yet.
: "${STARSHIP_CONFIG:=$ZDOTDIR/starship.toml}"
export STARSHIP_CONFIG

eval "$(starship init zsh)"
