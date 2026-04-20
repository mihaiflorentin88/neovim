return {
  "christoomey/vim-tmux-navigator",
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Navigate left across Neovim/tmux" })
    vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Navigate down across Neovim/tmux" })
    vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Navigate up across Neovim/tmux" })
    vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Navigate right across Neovim/tmux" })
  end,
}
