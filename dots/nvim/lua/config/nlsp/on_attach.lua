local M = {}

function M.create_on_attach()
  return function(client, bufnr)
    local map = function(mode, keys, func, desc, opts)
      if desc then desc = "LSP: " .. desc end

      opts = vim.tbl_deep_extend("force", { noremap = true, silent = true, buffer = bufnr, desc = desc }, opts or {})

      vim.keymap.set(mode, keys, func, opts)
    end

    map("n", "F", "<cmd>LspZeroFormat<CR>", "Format")

    -- map("n", "K", vim.lsp.buf.hover, "Hover Documentation") ----------- Already defined in global keys
    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Code
    map("n", "<leader>ca", "<cmd>CodeActionMenu<CR>", "Code Action")
    map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")

    if client.name == "typescript" or client.name == "tsserver" then
      map("n", "<leader>co", "<cmd>:TSLspOrganize<CR>", "TS Organize Imports")
      map("n", "<leader>cR", "<cmd>:TSLspRenameFile<CR>", "TS Rename File")
    end

    -- Gotos
    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gr", "<cmd>Trouble lsp_references<CR>", "Goto [R]eferences")
    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "gt", vim.lsp.buf.type_definition, "Goto Type Definition")

    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

    -- Utilize nvim-lsp-ts-utils for typescript code
    if client.name == "typescript" or client.name == "tsserver" then
      local ts = require("nvim-lsp-ts-utils")
      -- vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler
      ts.setup({
        disable_commands = false,
        enable_import_on_completion = true,
        import_on_completion_timeout = 5000,
        eslint_bin = "eslint_d", -- use eslint_d if possible!
        eslint_enable_diagnostics = true,
        -- eslint_fix_current = false,
        eslint_enable_disable_comments = true,
      })

      ts.setup_client(client)
    end
  end
end

return M
