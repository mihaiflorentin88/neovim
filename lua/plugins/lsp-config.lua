return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pylsp.setup({})
      lspconfig.gopls.setup({})
      lspconfig.helm_ls.setup({})
      lspconfig.html.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.lwc_ls.setup({})
      lspconfig.jsonls.setup({})
      lspconfig.bashls.setup({})
      lspconfig.dockerls.setup({})
      lspconfig.twiggy_language_server.setup({})
      lspconfig.markdown_oxide.setup({})
      lspconfig.puppet.setup({})
      lspconfig.harper_ls.setup({})
      lspconfig.bashls.setup({})
      lspconfig.sqlls.setup({})
      lspconfig.terraformls.setup({})
      lspconfig.yamlls.setup({})
      lspconfig.bashls.setup({})
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "gopls", "helm_ls", "html", "ts_ls", "lwc_ls", "jsonls", "bashls", "dockerls", "twiggy_language_server", "markdown_oxide", "phpactor", "puppet", "harper_ls", "bashls", "sqlls", "terraformls", "yamlls", "bashls"}
      })
    end
  }
}

