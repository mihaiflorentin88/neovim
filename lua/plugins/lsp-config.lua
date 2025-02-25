return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({capabilities = capabilities})
      lspconfig.pyright.setup({capabilities = capabilities})
      lspconfig.gopls.setup({capabilities = capabilities})
      lspconfig.helm_ls.setup({capabilities = capabilities})
      lspconfig.html.setup({capabilities = capabilities})
      lspconfig.ts_ls.setup({capabilities = capabilities})
      lspconfig.lwc_ls.setup({capabilities = capabilities})
      lspconfig.jsonls.setup({capabilities = capabilities})
      lspconfig.bashls.setup({capabilities = capabilities})
      lspconfig.dockerls.setup({capabilities = capabilities})
      lspconfig.twiggy_language_server.setup({capabilities = capabilities})
      lspconfig.markdown_oxide.setup({capabilities = capabilities})
      lspconfig.puppet.setup({capabilities = capabilities})
      lspconfig.harper_ls.setup({capabilities = capabilities})
      lspconfig.bashls.setup({capabilities = capabilities})
      lspconfig.sqlls.setup({capabilities = capabilities})
      lspconfig.terraformls.setup({capabilities = capabilities})
      lspconfig.yamlls.setup({capabilities = capabilities})
      lspconfig.bashls.setup({capabilities = capabilities})
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "gopls",
          "helm_ls",
          "html",
          "ts_ls",
          "lwc_ls",
          "jsonls",
          "bashls",
          "dockerls",
          "twiggy_language_server",
          "markdown_oxide",
          "phpactor",
          "puppet",
          "harper_ls",
          "bashls",
          "sqlls",
          "terraformls",
          "yamlls",
          "bashls",
        },
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "hadolint", "jq" },
        automatic_installation = true,
      })
    end,
  },
}
