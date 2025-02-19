return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.djhtml,
        null_ls.builtins.formatting.djlint,
        null_ls.builtins.formatting.duster,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.usort, -- python imports formater
        null_ls.builtins.formatting.pyink,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.pretty_php,
        null_ls.builtins.formatting.rustywind,
        null_ls.builtins.formatting.biome,
        null_ls.builtins.formatting.sqlfmt,

      }
    })
  end
}

