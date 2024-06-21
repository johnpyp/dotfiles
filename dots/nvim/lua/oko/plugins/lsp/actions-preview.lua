---This Lazy plugin does this cool thing
---
---@type LazySpec
return {
  {
    "aznhe21/actions-preview.nvim",
    opts = function()
      local hl = require("actions-preview.highlight")
      return {
        diff = {
          algorithm = "patience",
          ignore_whitespace = true,
          ctxlen = 3,
        },
        -- highlight_command = {
        --   hl.delta("delta --no-gitconfig --side-by-side"),
        -- },
        backend = { "nui" },

        nui = {
          keymap = {

            close = { "<Esc>", "<C-c>", "q" },
          },
          layout = {
            relative = "cursor",
            position = 1,
            size = {
              width = "50%",
              height = "30%",
            },
            -- width = 0.6,
            -- height = 0.6,
            -- row = 1,
          },
          preview = {
            size = "80%",
          },
          select = {
            size = "20%",
          },
        },
      }
    end,
    init = function(_self)
      vim.api.nvim_create_user_command(
        "ActionsPreviewCodeAction",
        function() require("actions-preview").code_actions() end,
        {}
      )
    end,
  },
}
