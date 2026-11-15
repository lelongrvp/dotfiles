# ~/.config/zsh/claude.zsh
#
# Reconstructed 2026-08-30 after ~/.config was wiped. The original was lost; this
# restores the two behaviours it demonstrably had:
#   - ~/.claude/secrets.env names this file as its loader
#   - cc-* helpers were invoked bare from the shell, so ~/.claude/bin was on PATH

# Claude Code helper scripts (cc-doctor, cc-session, cc-sync-obsidian, ...)
if [[ -d "$HOME/.claude/bin" ]]; then
  case ":$PATH:" in
    *":$HOME/.claude/bin:"*) ;;
    *) export PATH="$HOME/.claude/bin:$PATH" ;;
  esac
fi

# Machine-local secrets (AZURE_DEVOPS_PAT, optional ANTHROPIC_API_KEY)
[[ -f "$HOME/.claude/secrets.env" ]] && source "$HOME/.claude/secrets.env"

# Model and plan-mode shortcuts. cc-plan relies on opusplan: plan mode is Opus,
# leaving plan mode drops to Sonnet.
alias cc-sonnet='claude --model sonnet'
alias cc-opus='claude --model opus'
alias cc-plan='claude --permission-mode plan'
cc-fable() { claude --model fable "$@"; }
cc-hard() { claude --model fable --effort max "$@"; }
cc-lean() { command claude --strict-mcp-config "$@"; }

_cc_route() {
  local prompt="${(L)1}"
  case "$prompt" in
    *architecture*|*architect*|*"data model"*|*migration*|*refactor*|*"design the"*|*"plan the"*)
      print -l -- --model opus --effort high --permission-mode plan ;;
    *debug*|*"root cause"*|*concurren*|*"race condition"*|*security*|*permission*)
      print -l -- --model opus --effort high ;;
    *rename*|*format*|*lint*|*bump*|*upgrade*|*typo*|*"commit message"*|*"run tests"*|*"test run"*)
      print -l -- --model sonnet --effort low ;;
  esac
}

claude() {
  case "$1" in
    agents|attach|auth|auto-mode|doctor|gateway|import|install|logs|mcp|plugin|plugins|purge|respawn|rm|setup-token|stop|kill|ultrareview|--version|-v|--help|-h)
      command claude "$@"
      return ;;
  esac
  local joined="$*"
  local -a route
  if [[ "$joined" != *--model* && "$joined" != *--effort* && "$joined" != *--permission-mode* ]]; then
    route=("${(@f)$(_cc_route "$joined")}")
    [[ -n "${route[1]:-}" ]] || route=()
  fi
  command claude --strict-mcp-config "${route[@]}" "$@"
}
claude-mcp() { command claude "$@"; }
