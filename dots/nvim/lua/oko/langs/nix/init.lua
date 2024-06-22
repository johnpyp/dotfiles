---nix language server & formatter
---
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "nix" } }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      if vim.fn.executable('nix') == 1 then
        opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "nil_ls" })
      end
    end
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },
}
