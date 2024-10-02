return {
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.INFO,
      default_format_opts = {
        timeout_ms = 800,
        async = false,           -- not recommended to change
        quiet = false,           -- not recommended to change
        lsp_format = "fallback", -- not recommended to change

      }
    },
    init = function()
      local conform = require("conform")
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("ConformFormat", {}),
        callback = function(event) conform.format({ bufnr = event.buf, async = false }) end,
      })

      -- Manual format
      vim.api.nvim_create_user_command(
        "Format",
        function() conform.format() end,
        { desc = "Format selection or buffer" }
      )
    end,
  },
}
