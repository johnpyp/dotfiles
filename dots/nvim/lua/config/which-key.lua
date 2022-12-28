local wk = require("which-key")

local wk_presets = require("which-key.plugins.presets")

wk_presets.objects["a("] = nil

wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
  window = {
    border = "rounded",
  },
  show_keys = false,
})

wk.register({
  ["<leader>c"] = { name = "Code" },
  ["<leader>W"] = { name = "Quiet Save" },
  ["<leader>n"] = { name = "Nvim tree" },
})
