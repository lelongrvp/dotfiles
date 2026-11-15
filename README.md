# dotfiles

My macOS development environment, versioned so a new machine is one clone away.
The repository root **is** `~/.config`.

## What's inside

| Path | Tool | Notes |
| --- | --- | --- |
| `nvim/` | [Neovim](https://neovim.io) 0.12 | LazyVim v8, 17 extras, LSP via Mason, blink.cmp |
| `zsh/` | zsh | starship prompt, zoxide, fzf, fzf-tab, vi-mode, fast-syntax-highlighting |
| `alacritty/` | [Alacritty](https://alacritty.org) | Gruvbox colours, Hack Nerd Font, OSC 52, Ctrl+Shift+U URL hints |
| `tmux/` | tmux 3.8 | true colour, OSC 52, vi copy mode, `focus-events` on |
| `iterm2/` | iTerm2 | exported preferences (`com.googlecode.iterm2.plist`) |

## Install

Back up whatever is there first, then clone into place:

```bash
mv ~/.config ~/.config.bak
git clone https://github.com/lelongrvp/dotfiles.git ~/.config
```

Homebrew packages these configs assume:

```bash
brew install neovim git ripgrep fd bat eza zoxide fzf starship tmux lazygit git-delta
brew install --cask alacritty font-hack-nerd-font
```

Then start Neovim once. LazyVim bootstraps lazy.nvim, installs the plugins in
`nvim/lazy-lock.json`, and Mason pulls the language servers.

## Not in this repository

Deliberately ignored, because they hold credentials or machine-specific paths:

- `gh/`, `rclone/`, `b2/`, `cursor/`, `zed/`, `opencode/`, `raycast/`, `lazygit/`,
  `homebrew/`, `swiftpm/` — tool state; `gh/hosts.yml` and `rclone/rclone.conf`
  contain tokens.
- `music-get/env` — local API key.
- `zsh/.zsh_history`, `zsh/.zsh_sessions/`, `zsh/plugins/` — history, sessions and
  plugin clones that `zsh/plugins.zsh` recreates on demand.
- `iterm2/AppSupport` — a symlink into `~/Library`, meaningless on another machine.

`zsh/claude.zsh` sources `~/.claude/secrets.env` when it exists and defines
nothing itself, so no secrets live here.

## Neovim

Leader is `Space`. Most keys are LazyVim defaults; the entries below are the ones
worth remembering.

| Key | Action |
| --- | --- |
| `<leader>e` | File explorer |
| `<leader>ff` / `<leader>fg` | Find files / live grep |
| `<leader>at` | Toggle inline AI completion (minuet) |
| `<leader>gg` | Lazygit |
| `<C-/>` | Toggle terminal (toggleterm) |
| `<leader>lx` | LazyExtras |
| `gd`, `K`, `<leader>cr` | Definition, hover, rename |
| `:q` | Close the buffer, or return to the dashboard on the last one |

Formatting is Prettier for web filetypes, StyLua for Lua, and i18n JSON gets
sorted with `jq` before Prettier runs. `vtsls` organises TypeScript imports on
save, and saving a `tsconfig`, ESLint config or Tailwind entry restarts the
matching LSP.

## Shell

```
ls → eza --icons      ll → eza -lh --git      la → eza -lah --git
cat → bat             grep → rg               df → df -h
- → cd -              lf → lf, cd on exit
```

`zsh/plugins.zsh` clones its plugins into `zsh/plugins/` on first use and
sources them after `compinit`, which is why the load order in `.zshrc` matters.

## tmux

`focus-events on` is not cosmetic: Neovim's `FocusGained` autocmd runs
`checktime` to reload files changed on disk, and tmux swallows that event
without it. `set-clipboard on` plus Alacritty's `osc52 = "OnlyCopy"` keeps
copying to the macOS clipboard working across panes.

## License

MIT, see [LICENSE](LICENSE).
