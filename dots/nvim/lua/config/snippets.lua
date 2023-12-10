local luasnip = require("luasnip")

-- Snippets:

luasnip.config.setup({
  history = false,
  -- Update more often, :h events for more info.
  -- update_events = "TextChanged,TextChangedI",
  -- region_check_events = "InsertEnter",
  -- delete_check_events = "TextChanged,InsertLeave",
})

vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end, { "vscode", "snipmate", "lua" })
-- friendly-snippets - enable standardized comments snippets
require("luasnip").filetype_extend("typescript", { "tsdoc" })
require("luasnip").filetype_extend("javascript", { "jsdoc" })
require("luasnip").filetype_extend("lua", { "luadoc" })
require("luasnip").filetype_extend("python", { "python-docstring" })
require("luasnip").filetype_extend("rust", { "rustdoc" })
require("luasnip").filetype_extend("cs", { "csharpdoc" })
require("luasnip").filetype_extend("java", { "javadoc" })
require("luasnip").filetype_extend("sh", { "shelldoc" })
require("luasnip").filetype_extend("c", { "cdoc" })
require("luasnip").filetype_extend("cpp", { "cppdoc" })
require("luasnip").filetype_extend("php", { "phpdoc" })
require("luasnip").filetype_extend("kotlin", { "kdoc" })
require("luasnip").filetype_extend("ruby", { "rdoc" })

-- require("luasnip/loaders/from_vscode").lazy_load()
