local u = require("utils")
local lspinstall = require("lspinstall")
local servers = require("lsp.servers")

local api = vim.api
local lsp = vim.lsp


vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}

    -- Mappings.
    u.lua_command("LspDeclaration", "vim.lsp.buf.declaration()")
    u.lua_command("LspDefinition", "vim.lsp.buf.definition()")
    u.lua_command("LspTypeDefinition", "vim.lsp.buf.type_definition()")
    u.lua_command("LspImplementation", "vim.lsp.buf.implementation()")
    u.lua_command("LspReferences", "vim.lsp.buf.references()")
    u.lua_command("LspCodeAction", "vim.lsp.buf.code_action()")
    u.lua_command("LspRangeCodeAction", "vim.lsp.buf.range_code_action()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
    u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")


    u.buf_map("n", "gD", ":LspDeclaration<CR>", nil, bufnr)
    u.buf_map("n", "gd", ":LspDefinition<CR>", nil, bufnr)
    u.buf_map("n", "gt", ":LspTypeDefinition<CR>", nil, bufnr)
    u.buf_map("n", "gi", ":LspImplementation<CR>", nil, bufnr)
    u.buf_map("n", "gr", ":LspReferences<CR>", nil, bufnr)

    u.buf_map("n", "<leader>ca", ":LspCodeAction<CR>", nil, bufnr)
    u.buf_map("v", "<leader>ca", ":LspRangeCodeAction<CR>", nil, bufnr)
    u.buf_map("n", "<leader>cr", ":LspRename<CR>", nil, bufnr)

    u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.buf_map("n", "<C-k>", ":LspSignatureHelp<CR>", nil, bufnr)
    -- u.buf_map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- u.buf_map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- u.buf_map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    -- u.buf_map("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    -- u.buf_map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    -- u.buf_map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    -- u.buf_map("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        u.buf_map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", nil, bufnr)
        u.buf_augroup("LspFormatOnSave", "BufWritePre", "lua vim.lsp.buf.formatting()")
    elseif client.resolved_capabilities.document_range_formatting then
        u.buf_map("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", nil, bufnr)
    end
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lspInstall + lspconfig stuff


-- tsserver.setup(on_attach)
-- jsonls.setup(on_attach)

-- null_ls.setup(on_attach)
--
local function merge(a, b)
    if type(a) == 'table' and type(b) == 'table' then
        for k,v in pairs(b) do if type(v)=='table' and type(a[k] or false)=='table' then merge(a[k],v) else a[k]=v end end
    end
    return a
end

local function setup_servers()
    lspinstall.setup()

    local installed_servers = lspinstall.installed_servers()
    for _, lang in pairs(installed_servers) do
        local server_config = servers[lang]

        local orig_on_attach = server_config.on_attach
        local result_config = merge(server_config, {
            on_attach = function (client, bufnr)
                if orig_on_attach ~= nil then
                    orig_on_attach(client, bufnr)
                end

                on_attach(client, bufnr)
            end
        })

        require"lspconfig"[lang].setup(result_config)
    end
end
-- local function setup_servers()
--     lspinstall.setup()
--     local servers = lspinstall.installed_servers()
--
--     for _, lang in pairs(servers) do
--         if lang ~= "lua" then
--             if setup_map[lang] ~= nil then
--                 setup_map[lang](on_attach)
--             end
--         elseif lang == "lua" then
--             lspconfig[lang].setup {
--                 root_dir = vim.loop.cwd,
--                 settings = {
--                     Lua = {
--                         diagnostics = {
--                             globals = {"vim"}
--                         },
--                         workspace = {
--                             library = {
--                                 [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--                                 [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
--                             },
--                             maxPreload = 100000,
--                             preloadFileSize = 10000
--                         },
--                         telemetry = {
--                             enable = false
--                         }
--                     }
--                 }
--             }
--         end
--     end
-- end
--
-- setup_servers()
--
-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
setup_servers()
lspinstall.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- triggers FileType autocmd that starts the server
end

require'nlspsettings'.setup{}
