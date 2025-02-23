vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "dark"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false


-- Navigate vim panels better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Move rows up/down
-- Normal mode mappings
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = "Move current line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = "Move current line up" })
-- Visual mode mappings
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })


vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

-- LSP
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
