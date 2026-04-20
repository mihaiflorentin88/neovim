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

## Start tmux

Start a new tmux session:

```bash
tmux
```

Start a named session:

```bash
tmux new -s work
```

Start tmux and open Neovim immediately:

```bash
tmux new -s work 'nvim'
```

List sessions:

```bash
tmux ls
```

Attach to a session:

```bash
tmux attach -t work
```

Detach without closing anything:

```text
<prefix> d
```

Kill a session:

```bash
tmux kill-session -t work
```

## Prefix

Prefix is `<C-s>`.

| Key | Action |
| --- | --- |
| `<prefix> r` | Reload tmux config. |
| `<prefix> I` | Install TPM plugins. |
| `<prefix> U` | Update TPM plugins. |
| `<prefix> d` | Detach from tmux. |

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

## Copy mode

Use copy mode to scroll terminal output, search it, and copy text from command output.

| Key | Action |
| --- | --- |
| `<prefix> [` | Enter copy mode. |
| `q` | Leave copy mode. |
| `/text` | Search forward in copy mode. |
| `?text` | Search backward in copy mode. |
| `n` / `N` | Next / previous search result. |
| `<Space>` | Start selection. |
| `<Enter>` | Copy selection. |

Mouse mode is enabled, so you can also scroll panes with the mouse.

## Neovim integration

`vim-tmux-navigator` is installed in both Neovim and tmux. These keys move across Neovim splits and tmux panes:

| Key | Action |
| --- | --- |
| `<C-h>` | Left. |
| `<C-j>` | Down. |
| `<C-k>` | Up. |
| `<C-l>` | Right. |

This lets you treat Neovim splits and tmux panes like one grid. Example layout:

```text
┌───────────────────────────┬────────────────────┐
│ nvim                      │ shell              │
│                           │                    │
│ code split 1 | code split │ tests / git / logs │
└───────────────────────────┴────────────────────┘
```

From the Neovim split on the right, `<C-l>` moves into the shell pane. From the shell pane, `<C-h>` moves back into Neovim.

## Daily workflow

1. Start a named session for the project:
   ```bash
   cd ~/src/project
   tmux new -s project
   ```
2. Open Neovim in the first pane:
   ```bash
   nvim
   ```
3. Split a shell pane:
   ```text
   <prefix> %
   ```
4. Run tests, git commands, servers, or logs in the shell pane.
5. Move between Neovim and shell with `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>`.
6. Detach when leaving:
   ```text
   <prefix> d
   ```
7. Reattach later:
   ```bash
   tmux attach -t project
   ```

## Pairing Neovim with shell panes

Common layouts:

| Layout | How to use it |
| --- | --- |
| Editor + tests | Neovim on the left, `pytest`, `go test`, `npm test`, or `vim-test` output on the right. |
| Editor + server | Neovim on the left, local dev server on the right. |
| Editor + git | Neovim on the left, `git status`, `git diff`, and branch work on the right. |
| Editor + logs | Neovim on the left, `tail -f`, `journalctl -f`, or container logs on the right. |

With `vim-test`, test commands use Vimux, so test output can stay in tmux while you keep editing in Neovim.

## Use cases

### Long-running server

```bash
tmux new -s api
nvim
```

Create a second pane with `<prefix> %`, then run:

```bash
make dev
```

Detach with `<prefix> d`; the server keeps running.

### Focused debugging

Use one tmux pane for Neovim DAP, one pane for logs, and one pane for manual commands:

```text
<prefix> %
<prefix> "
```

Navigate with `<C-h/j/k/l>` and resize panes with `<M-Up/Down/Left/Right>`.

### Remote work

Start a named session on the remote machine:

```bash
tmux new -s remote-work
```

If SSH disconnects, reconnect and run:

```bash
tmux attach -t remote-work
```

Your Neovim buffers, shells, and running commands are still there.

### Multiple projects

Use one session per project:

```bash
tmux new -s api
tmux new -s frontend
tmux ls
tmux attach -t api
```

This keeps panes, directories, and running commands separated.

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
