---ruby lsp + formatter
---
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = "ruby" }
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      servers = { "ruby_lsp" },
      config = {
        ruby_lsp = {
          init_options = {
            formatter = "standard",
            linters = { "standard" }
          }
        }
      }
    }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = {} }
  },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = {
  --     formatters_by_ft = {
  --       ruby = { "standardrb" },
  --       eruby = { "erb_format" },
  --     },
  --   },
  -- }
}
