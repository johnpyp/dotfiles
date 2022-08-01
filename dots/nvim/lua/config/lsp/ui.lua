local icons = require "util.icons"
-- vim.ui.select = require("lspactions").select
-- vim.ui.input = require("lspactions").input

-- vim.lsp.handlers["textDocument/references"] = require("lspactions").references
-- vim.lsp.handlers["textDocument/definition"] = require("lspactions").definition
-- Show diagnostics in a pop-up window on hover
_G.LspDiagnosticsShowPopup =
  function() return vim.diagnostic.open_float(nil, { scope = "cursor", focusable = false, focus = false }) end
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

  -- Show the popup diagnostics window,
  -- but only once for the current cursor location (unless moved afterwards).
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor
    local _, winnr = _G.LspDiagnosticsShowPopup()
    if winnr ~= nil then
      vim.api.nvim_win_set_option(winnr, "winblend", 20) -- opacity for diagnostics
    end
  end
end

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
  focusable = false,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
  focusable = false,
})

-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
-- 	border = "single",
-- })

require("dressing").setup {
  input = {
    border = "rounded",
  },
}

vim.diagnostic.config {
  underline = true,
  signs = true,
  update_in_insert = false,
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
}
