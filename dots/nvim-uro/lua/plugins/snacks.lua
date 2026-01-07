---@type LazySpec
return {
  "folke/snacks.nvim",
  keys = {
    -- Disable built-in notification history because we use this for explorer
    { "<leader>n", false },
    {
      "<leader>N",
      function()
        if Snacks.config.picker and Snacks.config.picker.enabled then
          Snacks.picker.notifications()
        else
          Snacks.notifier.show_history()
        end
      end,
      desc = "Notification History",
    },
  },
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
