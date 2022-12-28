require("config.nlsp.mason").setup_mason_ui()

local lsp = require("lsp-zero")

lsp.preset("recommended")

require("lspconfig.ui.windows").default_options.border = "rounded"
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

lsp.set_preferences({
  set_lsp_keymaps = false,
})

lsp.set_server_config({
  flags = {
    debounce_text_changes = 75,
  },
})

lsp.on_attach(require("config.nlsp.on_attach").create_on_attach())

lsp.setup_nvim_cmp(require("config.nlsp.cmp").create_cmp_config())

local custom_settings = require("config.nlsp.settings")

lsp.configure("jsonls", custom_settings.jsonls)
lsp.configure("pyright", custom_settings.pyright)
lsp.configure("tsserver", custom_settings.tsserver)

require("neodev").setup()

local rust_lsp = lsp.build_options("rust_analyzer", {})

lsp.setup()

-- Initialize rust_analyzer with rust-tools
require("rust-tools").setup({ server = rust_lsp })

-- Setup crates.nvim for cargo.toml files
require("crates").setup()

-- make sure diagnostics are setup after lsp.setup()
require("config.nlsp.diagnostics").setup_config_diagnostics()

-- Make sure nls is imported *after* lsp setup
-- https://github.com/VonHeikemen/lsp-zero.nvim/issues/60#issuecomment-1363800412

local null_opts = lsp.build_options("null-ls", {})

require("config.nlsp.null_ls").setup_null_ls(null_opts)
require("config.nlsp.diagnostics").setup_diagnostic_higlights()

require("config.nlsp.autopairs").setup_autopairs()
