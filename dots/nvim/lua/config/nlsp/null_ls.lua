local M = {}

function M.setup_null_ls(nls_build_options)
  local nls = require("null-ls")
  local mason_nls = require("mason-null-ls")

  local lspformatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  nls.setup({
    debounce = 150,
    save_after_format = false,

    on_attach = function(client, bufnr)
      nls_build_options.on_attach(client, bufnr)

      -- Format on save, from https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = lspformatting_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = lspformatting_augroup,
          buffer = bufnr,
          callback = function()
            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
    sources = {
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      -- nls.builtins.formatting.fish_indent,
      -- nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
      nls.builtins.formatting.eslint_d,
      -- nls.builtins.formatting.ktlint,
      -- nls.builtins.diagnostics.shellcheck,
      -- nls.builtins.diagnostics.markdownlint,
      -- nls.builtins.diagnostics.selene,
      nls.builtins.code_actions.gitsigns,
    },
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".nvim.settings.json", ".git"),
  })

  -- setup mason_nullls after lsp??
  -- see documentation of null-null-ls for more configuration options!
  mason_nls.setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
  })
end

return M
