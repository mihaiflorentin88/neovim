return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {"lua", "python", "go", "javascript", "php", "html", "markdown", "bash", "json", "yaml", "ini"},
      })
    end
  }
}
