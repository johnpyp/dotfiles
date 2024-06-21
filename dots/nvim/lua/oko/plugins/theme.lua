---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      integrations = {
        alpha = true,
        cmp = true,
        fidget = true,
        lsp_saga = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        native_lsp = { enabled = true },
        neotree = true,
        noice = true,
        notify = true,
        treesitter = true,
        which_key = true,
      },
    },
    init = function(_plugin) vim.cmd.colorscheme("catppuccin") end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      return vim.tbl_extend("keep", opts, {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        theme = "catppuccin",
      },
    },
  },
}
