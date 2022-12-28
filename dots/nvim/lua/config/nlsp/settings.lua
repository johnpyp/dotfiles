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

return M
