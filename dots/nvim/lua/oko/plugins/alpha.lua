---@type LazySpec
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function(_, opts) return require("alpha.themes.startify").config end,
  -- config = function() require("alpha").setup(require("alpha.themes.startify").config) end,
}
