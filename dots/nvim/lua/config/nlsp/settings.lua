---@class nlsp.LspOpts
---@field settings? table
---@field capabilities? table
---@field flags? table
---@field cmd? table
---@field trace? "off" | "messages" | "verbose" | nil
---@field after_on_attach? nlsp.attach.AttachCtxFn
---@field before_on_attach? nlsp.attach.AttachCtxFn
---@field prefer_lsp_formatting? boolean

---@type table<string, nlsp.LspOpts>
local M = {}

M.jsonls = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
}

M.pyright = {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- M.rome = {
--   cmd = { "./node_modules/rome/bin/rome", "lsp-proxy", "--use-server" },
--   trace = "verbose",
--   settings = {
--     rome = {
--       requireConfiguration = true,
--     },
--   },
--   prefer_lsp_formatting = true,
-- }

M.tsserver = {
  settings = {
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "project-relative",
      },
    },
  },
  after_on_attach = function(_client, _bufnr, ctx)
    -- ctx.map("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", "TS Organize Imports")
    -- ctx.map("n", "<leader>cd", "<cmd>TypescriptGoToSourceDefinition<CR>", "TS Go To Definition (Source)")
    -- ctx.map("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", "TS Rename File")
  end,
}

M.rust_analyzer = {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      imports = {
        group = {
          enable = false,
        },
      },
      inlayHints = { locationLinks = false },
    },
  },
}

M.lua_ls = {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

return M
