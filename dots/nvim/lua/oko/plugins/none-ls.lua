---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  main = "null-ls",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "AstroNvim/astrolsp",
    {
      "jay-babu/mason-null-ls.nvim",
      dependencies = { "williamboman/mason.nvim" },
      -- cmd = { "NullLsInstall", "NullLsUninstall" },
      -- init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
      opts_extend = { "ensure_installed" },
      opts = { ensure_installed = {}, handlers = {} },
    },
  },
  -- event = "User AstroFile",
  opts = function() return { on_attach = require("astrolsp").on_attach } end,
}
