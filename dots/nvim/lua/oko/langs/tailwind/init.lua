---tailwind-tools
---
---@type LazySpec
return {
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}, -- your configuration
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("oko.utils").list_insert_unique(opts.ensure_installed, { "tailwindcss-language-server" })
    end,
  },
}
