---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  main = "null-ls",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "AstroNvim/astrolsp",
    "jay-babu/mason-null-ls.nvim",
  },
  -- event = "User AstroFile",
  opts = function() return { on_attach = require("astrolsp").on_attach } end,
}
