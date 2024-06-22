-- Ported & adjusted from:
-- https://github.com/AstroNvim/astrocommunity/blob/c95fc1b58ffbff4381b7c546e8aa8f913cd33c98/lua/astrocommunity/pack/lua/init.lua

---@type LazySpec
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    dependencies = {
      {

        "AstroNvim/astrolsp",
        optional = true,
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          config = {
            jsonls = {
              on_new_config = function(config)
                if not config.settings.json.schemas then config.settings.json.schemas = {} end
                vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
              end,
              settings = { json = { validate = { enable = true } } },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "json", "jsonc" })
      end
    end,
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "jsonls" })
  --   end,
  -- },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "json-lsp" })
    end,
  },
}
