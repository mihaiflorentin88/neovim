# Installation

This repository installs Neovim, tmux, or both. Neovim uses Lazy plugins and Mason-managed language tooling. Tmux uses TPM plugins and a `vim-tmux-navigator` setup that matches the Neovim pane navigation keys.

## Quick install

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

Dry run first:

```bash
~/.config/nvim/scripts/install-all-linux.sh --dry-run
~/.config/nvim/scripts/install-all-macos.sh --dry-run
~/.config/nvim/scripts/install-linux.sh --dry-run
~/.config/nvim/scripts/install-macos.sh --dry-run
~/.config/nvim/scripts/install-tmux-linux.sh --dry-run
~/.config/nvim/scripts/install-tmux-macos.sh --dry-run
```

## What the Neovim installers do

1. Install core OS packages:
   - macOS: `neovim`, `git`, `ripgrep` using Homebrew.
   - Linux: `neovim`, `git`, `ripgrep` using `apt-get`, `dnf`, or `pacman`.
2. Install this repository into `~/.config/nvim`.
3. Back up old Neovim runtime directories.
4. Run Lazy plugin sync:
   ```bash
   nvim --headless "+Lazy! sync" "+qa"
   ```
5. Start Neovim once so Mason can process configured language tools.
6. Open `README.md` headlessly as a smoke test.

## What the tmux installers do

1. Install `tmux` and `git`.
2. Back up old `~/.tmux.conf` and `~/.tmux/plugins`.
3. Link this repo's `tmux.conf` to `~/.tmux.conf`.
4. Clone TPM into `~/.tmux/plugins/tpm`.
5. Run TPM `install_plugins`.
6. Source the tmux config in a temporary tmux server as a smoke test.

## Backup behavior

Neovim installers back up these paths when they already exist:

```text
~/.config/nvim
~/.local/share/nvim
~/.local/state/nvim
~/.cache/nvim
```

Tmux installers back up these paths when they already exist:

```text
~/.tmux.conf
~/.tmux/plugins
```

Backups use a timestamp suffix:

```text
~/.config/nvim.backup-YYYYMMDD-HHMMSS
```

If you run the installer from the active checkout at `~/.config/nvim`, it keeps that config directory in place and only backs up runtime paths.

## Requirements

Required:

- Bash
- `git`
- Network access
- `sudo` for Linux package installs
- Homebrew for macOS package installs

Recommended:

- A Nerd Font for icons from `nvim-web-devicons`.
- `tmux` for tmux-only or full setup.

## Post-install checks

```bash
nvim --headless ~/.config/nvim/README.md "+qa"
nvim --headless "+checkhealth lazy" "+qa"
tmux -f ~/.tmux.conf start-server \; source-file ~/.tmux.conf \; display-message "tmux config loaded" \; kill-server
```

Inside Neovim:

```vim
:Lazy
:Mason
:checkhealth
```

Inside tmux:

```text
<prefix> r      reload config
<prefix> I      install TPM plugins
<C-h/j/k/l>     move across Neovim splits and tmux panes
```
