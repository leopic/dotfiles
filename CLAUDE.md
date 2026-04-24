# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup

Run the idempotent install script to apply configs and create symlinks:

```bash
./setup.sh
```

This installs Oh My Zsh, `z`, Atuin, tmux/teamocil, and creates symlinks for Claude Code:

```
dotfiles/claude/settings.json  →  ~/.claude/settings.json
dotfiles/claude/statusline.sh  →  ~/.claude/statusline.sh
dotfiles/claude/CLAUDE.md      →  ~/.claude/CLAUDE.md
```

`~/.claude/settings.local.json` is intentionally **not** symlinked — it holds local permission overrides.

## Architecture

This repo uses a **symlink pattern**: the dotfiles directory is the source of truth, and `setup.sh` links files into their active locations (`~/.claude/`, `~/`). Changes in the repo are immediately reflected via the symlinks.

### Claude Code config (`claude/`)

| File | Purpose |
|---|---|
| `claude/settings.json` | Model, statusline command, voice settings |
| `claude/statusline.sh` | 4-line bash status renderer (primary active file) |
| `claude/statusline.js` | Earlier Node.js statusline (superseded by .sh) |
| `claude/CLAUDE.md` | Collaboration guidelines (symlinked to `~/.claude/CLAUDE.md`) |

### statusline.sh layout

The statusline renders 4 lines on every prompt update:

- **Line 1**: `user@host | cwd | git branch +N/-N | staged/unstaged`
- **Line 2**: `ModelName (effort) | tokens / total`
- **Line 3**: Context bar | 5-hour rate limit | 7-day rate limit
- **Line 4**: Cost | API duration | token breakdown (input/output/cache)

Bars use `●○` chars and color-code by threshold: green (<40%), yellow (<75%), red (≥75%). The script depends on `jq` (resolved dynamically via `which jq` or Homebrew path).

### Shell config

- `bash_profile` — aliases, exports, helper functions (`up N`, `gcom`)
- `gitconfig` — aliases, diff-so-fancy pager, auto-rebase pull, LFS
- `vimrc` — desert theme, 2-space indent, 80-char ruler

### tmux sessions (`teamocil/`)

Pre-configured layouts invoked with `teamocil <name>`. Each `.yml` defines windows and panes for a recurring project environment.
