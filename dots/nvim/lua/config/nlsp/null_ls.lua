local formatting = require("config.nlsp.formatting")

---@class nlsp.NullLs
local M = {}

function M.setup_null_ls(nls_build_options)
  local nls = require("null-ls")
  local mason_nls = require("mason-null-ls")

  nls.setup({
    debounce = 150,
    -- save_after_format = false,

    on_attach = function(client, bufnr)
      nls_build_options.on_attach(client, bufnr)

      -- -- Format on save, from https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
      -- if client.supports_method("textDocument/formatting") then
      --   vim.api.nvim_clear_autocmds({ group = lspformatting_augroup, buffer = bufnr })
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     group = lspformatting_augroup,
      --     buffer = bufnr,
      --     callback = function()
      --       vim.lsp.buf.format({
      --         bufnr = bufnr,
      --         filter = function(c) return c.name == "null-ls" end,
      --       })
      --     end,
      --   })
      -- -- If null-ls doesn't support formatting, add an autoformat handler anyways and filter away null-ls
      -- else
      --   vim.api.nvim_clear_autocmds({ group = lspformatting_augroup, buffer = bufnr })
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     group = lspformatting_augroup,
      --     buffer = bufnr,
      --     callback = function()
      --       vim.lsp.buf.format({
      --         bufnr = bufnr,
      --         filter = function(c) return c.name ~= "null-ls" end,
      --       })
      --     end,
      --   })
      -- end
    end,
    sources = {
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      -- nls.builtins.formatting.rustfmt,
      nls.builtins.formatting.rustywind,
      -- nls.builtins.formatting.fish_indent,
      -- nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
      nls.builtins.formatting.ktlint,
      nls.builtins.formatting.nixfmt,
      nls.builtins.diagnostics.shellcheck,
      -- nls.builtins.diagnostics.markdownlint,
      -- nls.builtins.diagnostics.selene,
      nls.builtins.code_actions.gitsigns,

      ----------------
      --   Python   --
      ----------------
      nls.builtins.formatting.black,
      nls.builtins.formatting.isort,
      -- nls.builtins.diagnostics.pylint,
      nls.builtins.diagnostics.pylama,

      ----------------
      -- Typescript --
      ----------------
      nls.builtins.formatting.eslint_d,
      nls.builtins.code_actions.eslint_d,
      nls.builtins.diagnostics.eslint_d,
      nls.builtins.formatting.prettierd,
    },
    root_dir = require("null-ls.utils").root_pattern(
      ".null-ls-root",
      ".nvim.settings.json",
      ".git",
      ".project",
      ".projectkeep"
    ),
  })

  -- setup mason_nullls after lsp??
  -- see documentation of null-ls for more configuration options!
  mason_nls.setup({
    ensure_installed = {},
    automatic_installation = true,
    automatic_setup = false,
  })
end

return M
