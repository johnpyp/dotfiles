return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {

        explorer = {
          layout = { preset = "sidebar", layout = { position = "right" } },
          auto_close = true,
          win = {
            list = {
              keys = {
                ["."] = "toggle_hidden",
              },
            },
          },
        },
      },
    },
  },
}
