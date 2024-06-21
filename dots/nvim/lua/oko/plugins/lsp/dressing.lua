---This Lazy plugin does this cool thing
---
---@type LazySpec
return {
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        enabled = true,
        backend = { "builtin" },
        builtin = {
          show_numbers = false,

          mappings = {
            ["<Esc>"] = "Close",
            ["<C-c>"] = "Close",
            ["q"] = "Close",
            ["<CR>"] = "Confirm",
          },
          relative = "cursor",
          min_height = 1,
          -- Make the select not overlap the text
          override = function(winopt) winopt.row = winopt.row + 1 end,
        },
      },
    },
  },
}
