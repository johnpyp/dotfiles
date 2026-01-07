---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        enabled = false,
      },
      ty = {},
    },
  },
}
