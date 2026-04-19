# Keybindings

Leader key: `<Space>`.

Tmux prefix: `<C-s>`.

## Window navigation

| Key | Action |
| --- | --- |
| `<C-h>` | Move to the left split. |
| `<C-j>` | Move to the split below. |
| `<C-k>` | Move to the split above. |
| `<C-l>` | Move to the right split. |

When running inside tmux, the same `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>` keys move across both Neovim splits and tmux panes through `vim-tmux-navigator`.

## Editing

| Key | Mode | Action |
| --- | --- | --- |
| `<M-j>` | Normal | Move current line down. |
| `<M-k>` | Normal | Move current line up. |
| `<M-j>` | Visual | Move selected lines down. |
| `<M-k>` | Visual | Move selected lines up. |
| `<leader>h` | Normal | Clear search highlights. |

## LSP

| Key | Mode | Action |
| --- | --- | --- |
| `K` | Normal | Show hover documentation. |
| `gd` | Normal | Go to definition. |
| `<leader>ca` | Normal/Visual | Code action. |

## Formatting

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>gf` | Normal | Format current buffer through LSP/none-ls. |

## Telescope

| Key | Mode | Action |
| --- | --- | --- |
| `<C-p>` | Normal | Find files. |
| `<leader>fg` | Normal | Live grep in current project. |
| `<leader><leader>` | Normal | Recent files. |

## Neo-tree

| Key | Mode | Action |
| --- | --- | --- |
| `<C-n>` | Normal | Toggle filesystem tree on the left. |
| `<leader>bf` | Normal | Show open buffers in a floating Neo-tree window. |

## Completion

| Key | Mode | Action |
| --- | --- | --- |
| `<C-Space>` | Insert | Open completion menu. |
| `<C-b>` | Insert | Scroll completion docs up. |
| `<C-f>` | Insert | Scroll completion docs down. |
| `<C-e>` | Insert | Close completion menu. |
| `<CR>` | Insert | Confirm selected completion. |

## Debugging

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>du` | Normal | Toggle DAP UI. |
| `<leader>db` | Normal | Toggle breakpoint. |
| `<leader>dc` | Normal | Continue debug session. |
| `<F7>` | Normal | Step into. |
| `<F8>` | Normal | Step over. |
| `<F9>` | Normal | Step out. |

## Tests

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>tn` | Normal | Run nearest test. |
| `<leader>tf` | Normal | Run current test file. |
| `<leader>ta` | Normal | Run full test suite. |
| `<leader>tl` | Normal | Run last test. |
| `<leader>tv` | Normal | Visit last test file. |

## Tmux

| Key | Context | Action |
| --- | --- | --- |
| `<prefix> r` | tmux | Reload `~/.tmux.conf`. |
| `<prefix> I` | tmux | Install TPM plugins. |
| `<prefix> U` | tmux | Update TPM plugins. |
| `<prefix> c` | tmux | Create window. |
| `<prefix> ,` | tmux | Rename window. |
| `<prefix> &` | tmux | Kill window. |
| `<prefix> %` | tmux | Split pane horizontally. |
| `<prefix> "` | tmux | Split pane vertically. |
| `<prefix> x` | tmux | Kill pane. |
| `<prefix> z` | tmux | Toggle pane zoom. |
| `<M-Up>` | tmux | Resize pane up by 5. |
| `<M-Down>` | tmux | Resize pane down by 5. |
| `<M-Left>` | tmux | Resize pane left by 5. |
| `<M-Right>` | tmux | Resize pane right by 5. |
| `<C-h>` | Neovim/tmux | Move left across Neovim splits and tmux panes. |
| `<C-j>` | Neovim/tmux | Move down across Neovim splits and tmux panes. |
| `<C-k>` | Neovim/tmux | Move up across Neovim splits and tmux panes. |
| `<C-l>` | Neovim/tmux | Move right across Neovim splits and tmux panes. |
