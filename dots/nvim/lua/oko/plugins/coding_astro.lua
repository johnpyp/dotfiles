---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          -- require("astrolsp").setup
          -- set configuration options  as described below
        },
      },
      { "folke/neoconf.nvim", lazy = true, opts = {} },
      {
        "williamboman/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
        dependencies = { "williamboman/mason.nvim" },
        opts_extend = { "ensure_installed" },
        ---@type MasonLspconfigSettings
        opts = {
          automatic_installation = false,
          ensure_installed = {},
          -- use AstroLSP setup for mason-lspconfig
          handlers = { function(server) require("astrolsp").lsp_setup(server) end },
        },
      },
    },
    config = function()
      -- set up servers configured with AstroLSP
      vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
    end,
  },
}
