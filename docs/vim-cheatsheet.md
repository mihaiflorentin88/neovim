# Vim And Neovim Cheatsheet

## Movement

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | Left, down, up, right. |
| `w` / `b` | Next / previous word. |
| `e` | End of word. |
| `0` / `^` / `$` | Start of line / first non-blank / end of line. |
| `gg` / `G` | First / last line. |
| `{` / `}` | Previous / next paragraph. |
| `%` | Jump to matching bracket. |
| `<C-d>` / `<C-u>` | Half page down / up. |
| `<C-f>` / `<C-b>` | Full page down / up. |

## Editing

| Key | Action |
| --- | --- |
| `i` / `a` | Insert before / after cursor. |
| `I` / `A` | Insert at start / end of line. |
| `o` / `O` | New line below / above. |
| `x` | Delete character. |
| `dd` | Delete line. |
| `yy` | Yank line. |
| `p` / `P` | Paste after / before cursor. |
| `u` / `<C-r>` | Undo / redo. |
| `.` | Repeat last change. |

## Operators

| Pattern | Action |
| --- | --- |
| `dw` | Delete word. |
| `ciw` | Change inside word. |
| `di"` | Delete inside quotes. |
| `ci(` | Change inside parentheses. |
| `yap` | Yank around paragraph. |
| `>` / `<` in visual mode | Indent / unindent selection. |

## Search and replace

| Command | Action |
| --- | --- |
| `/text` | Search forward. |
| `?text` | Search backward. |
| `n` / `N` | Next / previous match. |
| `:%s/old/new/g` | Replace in file. |
| `:%s/old/new/gc` | Replace in file with confirmation. |
| `:noh` | Clear search highlights. |

## Files, buffers, and windows

| Command | Action |
| --- | --- |
| `:e path` | Edit file. |
| `:w` | Save file. |
| `:q` | Quit window. |
| `:wq` | Save and quit. |
| `:bd` | Delete current buffer. |
| `:ls` | List buffers. |
| `:b <number>` | Switch to buffer. |
| `:sp` / `:vsp` | Horizontal / vertical split. |
| `<C-w>h/j/k/l` | Move between splits. |
| `<C-h/j/k/l>` | Move between Neovim splits, and across tmux panes when inside tmux. |

## Visual mode

| Key | Action |
| --- | --- |
| `v` | Character visual mode. |
| `V` | Line visual mode. |
| `<C-v>` | Block visual mode. |
| `gv` | Reselect last visual selection. |
| `=` | Re-indent selection. |

## Helpful command-line mode tricks

| Key | Action |
| --- | --- |
| `<C-r>"` | Paste unnamed register into command line. |
| `<C-r>%` | Paste current file path into command line. |
| `:help topic` | Open help for a topic. |
