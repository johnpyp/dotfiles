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
  }
}
