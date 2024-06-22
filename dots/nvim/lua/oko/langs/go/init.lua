---golang support, lsps, etc.
---adapted from: https://github.com/AstroNvim/astrocommunity/blob/9ad5b67d06ef41e1ec58eb89d66704e0eb436228/lua/astrocommunity/pack/go/init.lua
---
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    opts = {
      ---@diagnostic disable-next-line: missing-fields
      config = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                ST1003 = true,
                fieldalignment = false,
                fillreturns = true,
                nilness = true,
                nonewvars = true,
                shadow = true,
                undeclaredname = true,
                unreachable = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              codelenses = {
                gc_details = true, -- Show a code lens toggling the display of gc's choices.
                generate = true,   -- show the `go generate` lens.
                regenerate_cgo = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              buildFlags = { "-tags", "integration" },
              completeUnimported = true,
              diagnosticsDelay = "500ms",
              matcher = "Fuzzy",
              semanticTokens = true,
              staticcheck = true,
              symbolMatcher = "fuzzy",
              usePlaceholders = true,
            },
          },
        },
      },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "go", "gomod", "gosum", "gowork" } }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "gopls", "gotests", "gomodifytags", "impl", "iferr" } }
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop", -- if you want develop branch
    -- keep in mind, it might break everything
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    -- (optional) will update plugin's deps on every update
    build = function()
      if not require("oko.utils").is_available("mason.nvim") then
        vim.print "Installing go dependencies..."
        vim.cmd.GoInstallDeps()
      end
    end,
    ---@type gopher.Config
    opts = {},
  }
}
