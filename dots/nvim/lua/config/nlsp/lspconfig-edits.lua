local configs = require("lspconfig.configs")
local lspconfig = require("lspconfig")

if not configs["v_analyzer"] then
  configs["v_analyzer"] = {
    default_config = {
      cmd = { "/home/johnpyp/.config/v-analyzer/bin/v-analyzer" },
      root_dir = lspconfig.util.root_pattern(".git", ".v-analyzer", "v.mod"),
      filetypes = { "v", "vlang", "vv", "vsh" },
    },
  }
end
