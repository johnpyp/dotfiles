---For the CodeCompanion ai plugin
---
---@type LazySpec
return {
  {

    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    config = {
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "copilot",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:cat ~/.secrets/anthropic_key.txt",
            },
          })
        end,
      },
    },
    keys = {
      { "<leader><S-c>", "<cmd>CodeCompanionChat<cr>", desc = "Open CodeCompanion" },
    },

  }
}
