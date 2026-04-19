# Tmux

This repo includes `tmux.conf` for a tmux setup that matches the Neovim navigation keys.

## Install

Full setup:

```bash
~/.config/nvim/scripts/install-all-macos.sh
~/.config/nvim/scripts/install-all-linux.sh
```

Tmux only:

```bash
~/.config/nvim/scripts/install-tmux-macos.sh
~/.config/nvim/scripts/install-tmux-linux.sh
```

The tmux installer backs up existing `~/.tmux.conf` and `~/.tmux/plugins`, links this repo's `tmux.conf` to `~/.tmux.conf`, installs TPM, and runs TPM plugin installation.

## Prefix

Prefix is `<C-s>`.

| Key | Action |
| --- | --- |
| `<prefix> r` | Reload tmux config. |
| `<prefix> I` | Install TPM plugins. |
| `<prefix> U` | Update TPM plugins. |

## Pane and window basics

| Key | Action |
| --- | --- |
| `<prefix> c` | Create a new window. |
| `<prefix> ,` | Rename current window. |
| `<prefix> &` | Kill current window. |
| `<prefix> %` | Split pane horizontally. |
| `<prefix> "` | Split pane vertically. |
| `<prefix> x` | Kill current pane. |
| `<prefix> z` | Toggle pane zoom. |
| `<M-Up>` | Resize pane up by 5. |
| `<M-Down>` | Resize pane down by 5. |
| `<M-Left>` | Resize pane left by 5. |
| `<M-Right>` | Resize pane right by 5. |

## Neovim integration

`vim-tmux-navigator` is installed in both Neovim and tmux. These keys move across Neovim splits and tmux panes:

| Key | Action |
| --- | --- |
| `<C-h>` | Left. |
| `<C-j>` | Down. |
| `<C-k>` | Up. |
| `<C-l>` | Right. |

## TPM plugins

| Plugin | Purpose |
| --- | --- |
| `tmux-plugins/tpm` | Plugin manager. |
| `christoomey/vim-tmux-navigator` | Shared Neovim/tmux pane navigation. |
| `catppuccin/tmux` | Catppuccin tmux theme. |
| `tmux-plugins/tmux-online-status` | Online/offline status. |
| `tmux-plugins/tmux-battery` | Battery status. |
| `tmux-plugins/tmux-cpu` | CPU status. |
| `pwittchen/tmux-plugin-ram` | RAM status. |

## Status bar

The status bar is at the top. It shows session, current command, current path, zoom status, battery, online status, date, and time.
