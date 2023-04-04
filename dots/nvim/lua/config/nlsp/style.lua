---@class nlsp.Style
local M = {}

---Apply styles to lsp handlers and mason
M.apply_styles = function()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    -- Uses `FloatBorder` highlights
    border = "rounded",
  })

  require("mason.settings").set({
    ui = {
      border = "rounded",
    },
  })
end

return M
