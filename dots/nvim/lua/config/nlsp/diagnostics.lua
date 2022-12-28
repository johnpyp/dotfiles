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

function M.setup_diagnostic_higlights()
  vim.cmd([[
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])
end

return M
