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

M.tsserver = {
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "project-relative",
    },
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

return M
