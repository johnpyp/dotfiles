vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

local on_attach = function(client)
  print("'" .. client.name .. "' language server started" );
end


require('nlua.lsp.nvim').setup(require('lspconfig'), {
  on_attach = on_attach,

  -- Include globals you want to tell the LSP are real :)
  globals = {
    -- Colorbuddy
    -- "Color", "c", "Group", "g", "s",
  }
})
require'lspconfig'.rust_analyzer.setup({ on_attach=on_attach })
require'lspconfig'.tsserver.setup({ on_attach=on_attach})

local prettier_format = function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end

-- require('formatter').setup({
--   logging = false,
--   filetype = {
--     javascript = {  prettier_format },
--     typescript = {  prettier_format },
--     vue = { prettier_format },
--     rust = {
--       -- Rustfmt
--       function()
--         return {
--           exe = "rustfmt",
--           args = {"--emit=stdout"},
--           stdin = true
--         }
--       end
--     },
--     lua = {
--         -- luafmt
--         function()
--           return {
--             exe = "luafmt",
--             args = {"--indent-count", 2, "--stdin"},
--             stdin = true
--           }
--         end
--       }
--   }
-- })

require'lspconfig'.diagnosticls.setup{
  on_attach=on_attach,
  filetypes={'javascript'},
  init_options = {
    linters = {
      eslint = {
        command = './node_modules/.bin/eslint',
        rootPatterns = {'.git'},
        debounce = 100,
        args = {
          '--stdin',
          '--stdin-filename',
          '%filepath',
          '--format',
          'json'
        },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning',
        },
      },
    },
    filetypes = {
      javascript = 'eslint',
      typescript = 'eslint'
    },
    -- formatters = {
    --   prettier = {
    --     command = "./node_modules/.bin/prettier",
    --     args = {"--stdin-filepath" ,"%filepath", '--single-quote', '--print-width 120'}
    --   }
    -- },
    -- formatFiletypes = {
    --   javascript = "prettier"
    -- },
  }
}

require'lspconfig'.vuels.setup{on_attach=on_attach}

  -- Commands:
  --
  -- Default Values:
  --   cmd = { "vls" }
  --   filetypes = { "vue" }
  --   init_options = {
  --     config = {
  --       css = {},
  --       emmet = {},
  --       html = {
  --         suggest = {}
  --       },
  --       javascript = {
  --         format = {}
  --       },
  --       stylusSupremacy = {},
  --       typescript = {
  --         format = {}
  --       },
  --       vetur = {
  --         completion = {
  --           autoImport = false,
  --           tagCasing = "kebab",
  --           useScaffoldSnippets = false
  --         },
  --         format = {
  --           defaultFormatter = {
  --             js = "none",
  --             ts = "none"
  --           },
  --           defaultFormatterOptions = {},
  --           scriptInitialIndent = false,
  --           styleInitialIndent = false
  --         },
  --         useWorkspaceDependencies = false,
  --         validation = {
  --           script = true,
  --           style = true,
  --           template = true
  --         }
  --       }
  --     }
  --   }
  --   root_dir = root_pattern("package.json", "vue.config.js")
