# Plugins

Plugins are managed by `lazy.nvim` and configured under `lua/plugins/`.

## Plugin list

| Plugin | Purpose | Config |
| --- | --- | --- |
| `folke/lazy.nvim` | Plugin manager bootstrapped by `init.lua`. | `init.lua` |
| `catppuccin/nvim` | Colorscheme, using `catppuccin-mocha`. | `lua/plugins/catppuccin.lua` |
| `goolord/alpha-nvim` | Startup dashboard. | `lua/plugins/alpha.lua` |
| `nvim-lualine/lualine.nvim` | Statusline. | `lua/plugins/lualine.lua` |
| `nvim-neo-tree/neo-tree.nvim` | File and buffer explorer. | `lua/plugins/neo-tree.lua` |
| `nvim-telescope/telescope.nvim` | Fuzzy finding files, grep, and history. | `lua/plugins/telescope.lua` |
| `nvim-telescope/telescope-ui-select.nvim` | Telescope UI picker integration. | `lua/plugins/telescope.lua` |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting and indentation. | `lua/plugins/treesitter.lua` |
| `neovim/nvim-lspconfig` | LSP server configuration. | `lua/plugins/lsp-config.lua` |
| `williamboman/mason.nvim` | External LSP/tool installer UI. | `lua/plugins/lsp-config.lua` |
| `williamboman/mason-lspconfig.nvim` | Mason integration for LSP servers. | `lua/plugins/lsp-config.lua` |
| `jay-babu/mason-null-ls.nvim` | Mason integration for none-ls tools. | `lua/plugins/lsp-config.lua` |
| `nvimtools/none-ls.nvim` | Formatter and diagnostic bridge. | `lua/plugins/none-ls.lua` |
| `hrsh7th/nvim-cmp` | Completion menu. | `lua/plugins/completions.lua` |
| `hrsh7th/cmp-nvim-lsp` | LSP completion source. | `lua/plugins/completions.lua` |
| `L3MON4D3/LuaSnip` | Snippet engine. | `lua/plugins/completions.lua` |
| `saadparwaiz1/cmp_luasnip` | LuaSnip completion source. | `lua/plugins/completions.lua` |
| `rafamadriz/friendly-snippets` | Community snippet collection. | `lua/plugins/completions.lua` |
| `mfussenegger/nvim-dap` | Debug adapter protocol client. | `lua/plugins/debugging.lua` |
| `rcarriga/nvim-dap-ui` | Debugger UI. | `lua/plugins/debugging.lua` |
| `nvim-neotest/nvim-nio` | Async dependency for DAP UI. | `lua/plugins/debugging.lua` |
| `leoluz/nvim-dap-go` | Go debugging helpers. | `lua/plugins/debugging.lua` |
| `mfussenegger/nvim-dap-python` | Python debugpy integration. | `lua/plugins/debugging.lua` |
| `jay-babu/mason-nvim-dap.nvim` | Mason integration for DAP adapters. | `lua/plugins/debugging.lua` |
| `theHamsta/nvim-dap-virtual-text` | Inline debug values. | `lua/plugins/debugging.lua` |
| `vim-test/vim-test` | Test runner commands. | `lua/plugins/vim-test.lua` |
| `preservim/vimux` | Send test commands to tmux. | `lua/plugins/vim-test.lua` |
| `christoomey/vim-tmux-navigator` | Navigate Vim and tmux panes. | `lua/plugins/tmux-navigator.lua` |
| `tmux-plugins/tpm` | tmux plugin manager. | `tmux.conf` |
| `christoomey/vim-tmux-navigator` | tmux side of shared pane navigation. | `tmux.conf` |
| `catppuccin/tmux` | tmux Catppuccin theme. | `tmux.conf` |
| `tmux-plugins/tmux-online-status` | Online/offline indicator. | `tmux.conf` |
| `tmux-plugins/tmux-battery` | Battery indicator. | `tmux.conf` |
| `tmux-plugins/tmux-cpu` | CPU status plugin. | `tmux.conf` |
| `pwittchen/tmux-plugin-ram` | RAM status plugin. | `tmux.conf` |

## Common plugin commands

```vim
:Lazy
:Lazy sync
:Lazy update
:Mason
:LspInfo
:NullLsInfo
:TSInstallInfo
```

## Configured LSP servers

The config requests these servers through `mason-lspconfig`:

```text
lua_ls, pyright, gopls, helm_ls, html, ts_ls, lwc_ls, jsonls, bashls,
dockerls, twiggy_language_server, markdown_oxide, phpactor, puppet,
harper_ls, sqlls, terraformls, yamlls
```

## Configured formatters and diagnostics

`none-ls.nvim` registers formatters for Lua, Django/Jinja HTML, Python, Go, JavaScript, PHP, Tailwind/Rustywind, Biome, and SQL. It also registers `hadolint` diagnostics for Dockerfiles.

## Configured debug adapters

Mason DAP installs:

```text
delve, debugpy, php-debug-adapter
```

See [Debugging](debugging.md) for Go, Python, and PHP examples.
