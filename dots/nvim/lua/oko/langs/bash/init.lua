---bash formatting/linting
---
---@type LazySpec
return {
  {
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      optional = true,
      opts = { ensure_installed = { "shellcheck", "shfmt" } }
    },
    {
      "stevearc/conform.nvim",
      optional = true,
      opts = {
        formatters_by_ft = {
          bash = { "shfmt" },
          sh = { "shfmt" },
        },
      },
    },
  }
}
