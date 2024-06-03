local lspconfig_util = require("lspconfig.util")

---@class nlsp.LspOpts
---@field settings? table
---@field capabilities? table
---@field flags? table
---@field cmd? table
---@field filetypes? table
---@field trace? "off" | "messages" | "verbose" | nil
---@field after_on_attach? nlsp.attach.AttachCtxFn
---@field before_on_attach? nlsp.attach.AttachCtxFn
---@field prefer_lsp_formatting? boolean
---@field single_file_support? boolean
---@field root_dir? function

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

M.vtsls = {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
}

M.volar = {
  init_options = {
    vue = {
      hybridMode = false,
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
    -- init_options = {
    --   preferences = {
    --     importModuleSpecifierPreference = "project-relative",
    --   },
    -- },
    -- javascript = {

    --   preferences = {
    --     importModuleSpecifierPreference = "relative",
    --   },
    -- },
    -- typescript = {
    --   preferences = {
    --     importModuleSpecifierPreference = "relative",
    --   },
    -- },
  },
  root_dir = lspconfig_util.root_pattern("package.json"),
  -- single_file_support = false,
  after_on_attach = function(_client, _bufnr, ctx)
    -- ctx.map("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", "TS Organize Imports")
    -- ctx.map("n", "<leader>cd", "<cmd>TypescriptGoToSourceDefinition<CR>", "TS Go To Definition (Source)")
    -- ctx.map("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", "TS Rename File")
  end,
}

M.denols = {
  settings = {
    ["deno"] = {
      unstable = true,
    },
  },
  root_dir = lspconfig_util.root_pattern("deno.json", "deno.jsonc"),
  -- single_file_support = true,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "typescriptdeno",
  },
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

M.tailwindcss = {
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      experimental = {
        classRegex = {
          "tw`([^`]*)",             -- tw`...`
          "tw\\.[^`]+`([^`]*)`",    -- tw.xxx<xxx>`...`
          "tw\\(.*?\\).*?`([^`]*)", -- tw(Component)<xxx>`...`
          -- "tw`([^`]*)",
          -- 'tw="([^"]*)',
          -- 'tw={"([^"}]*)',
          -- "tw\\.\\w+`([^`]*)",
          -- "tw\\(.*?\\)`([^`]*)",
          -- { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          -- { "classnames\\(([^)]*)\\)", "'([^']*)'" },
          -- { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
        },
      },
      validate = true,
    },
  },
}

return M
