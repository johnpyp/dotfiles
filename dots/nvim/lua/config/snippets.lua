local luasnip = require("luasnip")

-- Snippets:

luasnip.config.set_config({
  history = false,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").load()
