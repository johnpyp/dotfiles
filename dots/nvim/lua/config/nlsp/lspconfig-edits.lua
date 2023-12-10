local configs = require("lspconfig.configs")
local lspconfig = require("lspconfig")

-- if not configs["v-analyzer"] then
--   configs["v-analyzer"] = {
--     default_config = {
--       cmd = { "/home/johnpyp/.config/v-analyzer/bin/v-analyzer" },
--       root_dir = lspconfig.util.root_pattern(".git", ".v-analyzer"),
--       filetypes = { "v", "vlang" },
--     },
--   }
-- end
