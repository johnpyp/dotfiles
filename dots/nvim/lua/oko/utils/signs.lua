local M = {}

M.signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

-- Maps to "severity" labels, namely for bufferline/diagnostics
M.severity = {
  error = M.signs.Error,
  warning = M.signs.Warn,
  info = M.signs.Info,
  hint = M.signs.Hint,
}

function M.setup_signs_diagnostics()
  -- Automatically update diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = M.signs.Error,
        [vim.diagnostic.severity.WARN] = M.signs.Warn,
        [vim.diagnostic.severity.INFO] = M.signs.Info,
        [vim.diagnostic.severity.HINT] = M.signs.Hint,
      },
    },
  })
end

return M
