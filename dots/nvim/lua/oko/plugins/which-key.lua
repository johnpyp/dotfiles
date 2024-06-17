---@type LazySpec
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    -- vim.o.timeoutlen = 300
    local wk = require("which-key")
    local wk_presets = require("which-key.plugins.presets")

    wk_presets.objects["a("] = nil
    wk.register({
      ["<leader>c"] = { name = "code" },
      -- ["<leader>W"] = { name = "Quiet Save" },
      -- ["<leader>n"] = { name = "Nvim tree" },
      ["<leader>t"] = { name = "fzf" },
    })
  end,
  opts = {
    window = {
      border = "rounded",
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
