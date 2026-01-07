---@type LazySpec
return {
  "folke/noice.nvim",
  opts = {
    routes = {
      -- Suppress neo-tree toggle hidden notifications
      {
        filter = {
          event = "notify",
          kind = "info",
          any = {
            { find = "hidden" },
          },
        },
        opts = { skip = true },
      },
    },
  },
}
