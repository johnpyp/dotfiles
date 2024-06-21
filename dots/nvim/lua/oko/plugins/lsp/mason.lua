---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
    build = ":MasonUpdate",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {},
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "williamboman/mason.nvim" },
    -- cmd = { "NullLsInstall", "NullLsUninstall" },
    -- init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = {}, handlers = {}, methods = { formatting = false } },
  },
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
}

-- require("mason-lspconfig")
