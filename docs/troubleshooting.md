# Troubleshooting

## Run health checks

```bash
nvim --headless "+checkhealth lazy" "+qa"
nvim --headless "+checkhealth mason" "+qa"
nvim --headless "+checkhealth lspconfig" "+qa"
```

Inside Neovim:

```vim
:checkhealth
:Lazy
:Mason
:LspInfo
:NullLsInfo
```

## Lazy plugin recovery

If plugins are missing or outdated:

```bash
nvim --headless "+Lazy! sync" "+qa"
```

For interactive inspection:

```vim
:Lazy
```

Useful Lazy actions:

| Action | Meaning |
| --- | --- |
| `sync` | Install, clean, and update plugins to the lockfile. |
| `update` | Update plugins and lockfile. |
| `restore` | Restore plugins to `lazy-lock.json`. |
| `clean` | Remove unused plugin directories. |

## Mason tool recovery

Open Mason:

```vim
:Mason
```

Then install or update missing LSP servers, formatters, and linters.

Configured Mason integrations live in:

```text
lua/plugins/lsp-config.lua
```

## Formatter problems

Format current buffer:

```vim
<leader>gf
```

Check none-ls:

```vim
:NullLsInfo
```

Formatter config lives in:

```text
lua/plugins/none-ls.lua
```

## File tree problems

Toggle Neo-tree:

```vim
<C-n>
```

If file opening fails, first run:

```bash
nvim --headless ~/.config/nvim/README.md "+qa"
```

Then inspect plugin status:

```vim
:Lazy
```

## Reset plugin state

The installer backs up runtime directories automatically. Manual reset:

```bash
mv ~/.local/share/nvim ~/.local/share/nvim.backup-manual
mv ~/.local/state/nvim ~/.local/state/nvim.backup-manual
mv ~/.cache/nvim ~/.cache/nvim.backup-manual
nvim --headless "+Lazy! sync" "+qa"
```

Do not delete backups until the new setup opens normally.

## TPM and tmux recovery

Reload tmux config:

```text
<prefix> r
```

Install tmux plugins:

```text
<prefix> I
```

Run plugin installation directly:

```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

Smoke-test the config:

```bash
tmux -f ~/.tmux.conf start-server \; source-file ~/.tmux.conf \; display-message "tmux config loaded" \; kill-server
```

If TPM is missing:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
```

If Neovim/tmux pane navigation fails:

1. Confirm `christoomey/vim-tmux-navigator` is installed in both Lazy and TPM.
2. Reload tmux with `<prefix> r`.
3. Restart Neovim inside tmux.
4. Test `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>` from both a Neovim split and a shell pane.

## Debugger recovery

Install or repair debug adapters:

```vim
:MasonInstall delve debugpy php-debug-adapter
```

Check Python debugpy:

```bash
python -m debugpy --version
```

Check Go Delve:

```bash
dlv version
```

Check PHP Xdebug:

```bash
php -m | grep -i xdebug
```

If PHP breakpoints do not hit, confirm Xdebug uses port `9003` and that Neovim is listening with the `Listen for Xdebug` configuration.

See [Debugging](debugging.md) for full Go, Python, and PHP workflows.
