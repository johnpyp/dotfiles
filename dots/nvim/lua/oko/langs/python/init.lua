---This Lazy plugin does this cool thing
---
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        ruff = { on_attach = function(client) client.server_capabilities.hoverProvider = false end },
        pyright = {
          before_init = function(_, c) c.settings.python.pythonPath = vim.fn.exepath("python") end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
              },
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
        opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "python", "toml" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "pyright", "ruff" })
    end,
  },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = vim.tbl_filter(
  --       function(v) return not vim.tbl_contains({ "black", "isort" }, v) end,
  --       opts.ensure_installed
  --     )
  --   end,
  -- },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "ruff" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
