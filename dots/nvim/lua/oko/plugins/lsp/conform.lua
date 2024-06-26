local format_opts = {
  timeout_ms = 300,
  async = false, -- not recommended to change
  quiet = false, -- not recommended to change
  lsp_format = "fallback", -- not recommended to change
}

return {
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.INFO,
    },
    init = function()
      local conform = require("conform")
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("ConformFormat", {}),
        callback = function(event) conform.format(vim.tbl_extend("force", format_opts, { bufnr = event.buf })) end,
      })

      -- Manual format
      vim.api.nvim_create_user_command(
        "Format",
        function() conform.format(format_opts) end,
        { desc = "Format selection or buffer" }
      )
    end,
  },
}
