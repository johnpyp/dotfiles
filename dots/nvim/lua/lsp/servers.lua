local ts_utils = require("nvim-lsp-ts-utils")

local M = {}

local ts_utils_settings = {
    -- debug = true,
    enable_import_on_completion = true,
    import_all_scan_buffers = 100,
    eslint_bin = "eslint_d",
    eslint_enable_diagnostics = true,
    enable_formatting = true,
    formatter = "eslint_d",
    update_imports_on_move = true,
}

M.servers = {
    json = {
        filetypes = { 'json', 'jsonc' },
        -- settings = {
        --   json = {
        --     schemas = require'nlspsettings.jsonls'.get_default_schemas()
        --   }
        -- }
    },
    typescript = {
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            on_attach(client)

            ts_utils.setup(ts_utils_settings)
            ts_utils.setup_client(client)

            u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
            u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
            u.buf_map("n", "go", ":TSLspImportAll<CR>", nil, bufnr)
            u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
            u.buf_map("i", ".", ".<C-x><C-o>", nil, bufnr)

            vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
    }
}

return M.servers
