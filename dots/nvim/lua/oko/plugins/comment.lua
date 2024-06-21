--- Configures Commenting plugins with treesitter interop and whatnot
---
---@type LazySpec
return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {
      ignore = "^$",
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      -- This should stay as FALSE, otherwise it adds performance overhead. This is taken care of instead by the `Comment` hook
      -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
      enable_autocmd = false,
    },
  },
}
