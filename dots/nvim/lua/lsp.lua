local custom_attach = function(client)
  print("'" .. client.name .. "' language server started" );

  -- require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)

end


require'nvim_lsp'.sumneko_lua.setup{
  on_attach=custom_attach,
  cmd = { "/home/johnpyp/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/joh npyp/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua" },
  settings = {
      Lua = {
        diagnostics = {globals = {"vim"}},
        completion = {keywordSnippet = "Disable"},
        runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
          }
        }
      }
  }
}
require'nvim_lsp'.rust_analyzer.setup{on_attach=custom_attach}
require'nvim_lsp'.tsserver.setup{on_attach=custom_attach}
