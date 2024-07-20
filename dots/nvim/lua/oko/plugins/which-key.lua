---@type LazySpec
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    -- vim.o.timeoutlen = 300
    local wk = require("which-key")
    -- local wk_presets = require("which-key.plugins.presets")

    -- wk_presets.objects["a("] = nil
    wk.add({
      { "<leader>c", group = "code" },
      { "<leader>t", group = "fzf" }
    })
  end,
  opts = {
    win = {
      border = "rounded",
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
