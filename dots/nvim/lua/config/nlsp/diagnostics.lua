local icons = require("util.icons")

local M = {}

function M.setup_config_diagnostics()
  vim.diagnostic.config({
    underline = true,
    signs = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
      border = "single",
      focusable = false,
      header = { icons.debug .. " Diagnostics:", "Normal" },
      source = "always",
    },
    virtual_text = {
      spacing = 4,
      source = "always",
      severity = {
        min = vim.diagnostic.severity.HINT,
      },
    },
  })
end

return M
