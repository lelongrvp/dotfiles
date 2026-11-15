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
cc-lean() { claude --strict-mcp-config "$@"; }
