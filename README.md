# Neovim Config

Personal Neovim configuration using `lazy.nvim`, LSP, Mason, Telescope, Neo-tree, Treesitter, none-ls, completion, snippets, debugging, and test helpers.

## Quick Install

Clone the repo:

```bash
git clone git@github.com:mihaiflorentin88/neovim.git ~/.config/nvim
```

Full setup, macOS:

```bash
~/.config/nvim/scripts/install-all-macos.sh
```

Full setup, Linux:

```bash
~/.config/nvim/scripts/install-all-linux.sh
```

Neovim only, macOS:

```bash
~/.config/nvim/scripts/install-macos.sh
```

Neovim only, Linux:

```bash
~/.config/nvim/scripts/install-linux.sh
```

Tmux only, macOS:

```bash
~/.config/nvim/scripts/install-tmux-macos.sh
```

Tmux only, Linux:

```bash
~/.config/nvim/scripts/install-tmux-linux.sh
```

Preview first:

```bash
~/.config/nvim/scripts/install-all-linux.sh --dry-run
~/.config/nvim/scripts/install-all-macos.sh --dry-run
~/.config/nvim/scripts/install-linux.sh --dry-run
~/.config/nvim/scripts/install-macos.sh --dry-run
~/.config/nvim/scripts/install-tmux-linux.sh --dry-run
~/.config/nvim/scripts/install-tmux-macos.sh --dry-run
```

## What Gets Installed

- Neovim, Git, and ripgrep.
- tmux and TPM when using tmux-only or full setup.
- This config in `~/.config/nvim`.
- `tmux.conf` linked to `~/.tmux.conf`.
- Lazy plugins from `lazy-lock.json`.
- tmux plugins from TPM.
- Mason-managed LSP and formatter tooling configured in `lua/plugins/lsp-config.lua`.

Existing Neovim config/data/state/cache directories are backed up before install. See [Installation](docs/installation.md).

## Documentation

- [Installation](docs/installation.md)
- [Plugins](docs/plugins.md)
- [Tmux](docs/tmux.md)
- [Debugging](docs/debugging.md)
- [Keybindings](docs/keybindings.md)
- [Vim and Neovim Cheatsheet](docs/vim-cheatsheet.md)
- [Troubleshooting](docs/troubleshooting.md)

## Common Commands

```vim
:Lazy
:Mason
:LspInfo
:NullLsInfo
:checkhealth
```

## Repo Layout

```text
init.lua                 Bootstrap lazy.nvim and load settings/plugins.
lua/settings.lua         Core Neovim options and base keymaps.
lua/plugins/             Plugin specs and plugin-specific keymaps.
scripts/                 macOS/Linux install scripts.
docs/                    Installation, plugin, and cheatsheet docs.
tmux.conf                tmux + TPM + vim-tmux-navigator config.
lazy-lock.json           Locked plugin versions.
```

## Tmux

The full and tmux-only installers link this automatically. Manual setup:

```bash
ln -s ~/.config/nvim/tmux.conf ~/.tmux.conf
```
