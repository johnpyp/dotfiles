-- require("config.lsp.ui")
require("lspsaga").setup({
  code_action_keys = {
    quit = "<ESC>",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<ESC>",
    exec = "<CR>",
  },
})
require("config.lsp.ui")
require("config.lsp.diagnostics").setup()
require("config.lsp.kind").setup()

require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
})

require("config.lsp.mason")

local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)

  -- vim.cmd([[
  --    augroup AutoDiagnostics
  --      autocmd! * <buffer>
  --      autocmd CursorHold,DiagnosticChanged <buffer> lua _G.LspDiagnosticsPopupHandler()
  --    augroup END
  --  ]])
  -- require("lsp_signature").on_attach(client, bufnr)

  -- TypeScript specific stuff
  if client.name == "typescript" or client.name == "tsserver" then require("config.lsp.ts-utils").setup(client) end
end

local neodev = require("neodev").setup({
  library = {
    vimruntime = true,
    types = true,
    plugins = true,
  },
  runtime_path = true,
})

local servers = {
  -- ansiblels = {},
  bashls = {},
  -- clangd = {},
  cssls = {},
  dockerls = {},
  eslint = {},
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
    single_file_support = true,
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  sumneko_lua = neodev,
  tsserver = {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "project-relative",
      },
    },
  },
  vimls = {},
  gopls = {},
  kotlin_language_server = {},
  tailwindcss = {},
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 75,
  },
}

require("config.lsp.null-ls").setup(options)
require("config.lsp.setup").setup_servers(servers, options)
