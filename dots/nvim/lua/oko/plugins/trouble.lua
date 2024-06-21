---@type LazySpec
return {
  "folke/trouble.nvim",
  opts = {

    auto_open = false,
    auto_close = false,
    keys = {
      ["<esc>"] = "close",
    },
  },
  lazy = false,

  keys = {
    { "<leader>l", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>", desc = "Diagnostics" }, -- Find files
  },
}
