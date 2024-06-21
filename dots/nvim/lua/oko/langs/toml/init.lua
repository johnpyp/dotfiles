-- Ported & adjusted from:
-- https://github.com/AstroNvim/astrocommunity/blob/c95fc1b58ffbff4381b7c546e8aa8f913cd33c98/lua/astrocommunity/pack/toml/init.lua

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table or string "all".
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "toml" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "taplo" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "taplo" })
    end,
  },
}
