local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

require("config.plugins")
require("config.general")
require("config.theme")
require("config.keys")

-- require("config.snippets")
-- require("config.cmp")
-- require("config.lsp")
--
require("config.nlsp")
-- require("config.noice")

require("config.tree")
require("config.lualine")
require("config.bufferline")
require("config.misc")
require("config.which-key")
require("config.filetype")
