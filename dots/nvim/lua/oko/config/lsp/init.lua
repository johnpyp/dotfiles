vim.api.nvim_create_user_command(
  "LspLineDiagnostics",
  function()
    vim.diagnostic.open_float({
      border = "rounded",
      source = true,
      severity_sort = true,
      scope = "line",
    })
  end,
  {}
)

require("oko.utils.signs").setup_signs_diagnostics()

require("oko.config.lsp.lsp_keymaps")
