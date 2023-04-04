local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local custom_settings = require("config.nlsp.settings")

local lspconfig = require("lspconfig")

local my_on_attach = require("config.nlsp.on_attach")

local get_custom_server_opts = function(server_name)
  -- Defaults
  local capabilities = lsp_capabilities
  local after_on_attach = nil
  local before_on_attach = nil
  local settings = {}
  local flags = {
    debounce_text_changes = 75,
  }

  -- Overrides
  if server_name ~= nil and custom_settings[server_name] ~= nil then
    local lsps_settings = custom_settings[server_name]
    capabilities = lsps_settings["capabilities"] or lsp_capabilities
    before_on_attach = lsps_settings["before_on_attach"] or nil
    after_on_attach = lsps_settings["after_on_attach"] or nil
    settings = lsps_settings["settings"] or {}
  end

  local combined_on_attach = function(client, bufnr)
    local ctx = my_on_attach.create_context(client, bufnr)
    if before_on_attach ~= nil then before_on_attach(client, bufnr, ctx) end
    my_on_attach.common_on_attach(client, bufnr, ctx)
    if after_on_attach ~= nil then after_on_attach(client, bufnr, ctx) end
  end

  return {
    on_attach = combined_on_attach,
    capabilities = capabilities,
    settings = settings,
    flags = flags,
  }
end

local custom_setup_wrapper = function(server_name)
  return function()
    local opts = get_custom_server_opts(server_name)
    lspconfig[server_name].setup(opts)
  end
end

-- ## Pre-LSP setup

-- Setup nvim_cmp
require("config.nlsp.cmp").setup_cmp()
require("config.nlsp.cmp").setup_cmp_highlights()

-- Setup lsp styles
require("config.nlsp.style").apply_styles()
require("lspconfig.ui.windows").default_options.border = "rounded" -- Applies rounded border to the ":LspInfo" command
vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

-- Setup Language server plugins that should be setup before generic lsp setup
require("neodev").setup({
  pathStrict = true,
})

-- ## LSP setup

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "jsonls",
    "pyright",
    "tsserver",
    "rust_analyzer",
    "lua_ls",
  },
})

require("mason-lspconfig").setup_handlers({
  function(server_name)
    local opts = get_custom_server_opts(server_name)
    lspconfig[server_name].setup(opts)
  end,
  ["jsonls"] = custom_setup_wrapper("jsonls"),
  ["pyright"] = custom_setup_wrapper("pyright"),
  ["lua_ls"] = custom_setup_wrapper("lua_ls"),
  ["rust_analyzer"] = function()
    require("rust-tools").setup({
      server = get_custom_server_opts("rust_analyzer"),
    })
  end,
  ["tsserver"] = function()
    require("typescript").setup({
      server = get_custom_server_opts("tsserver"),
    })
  end,
})

-- ## Post-LSP setup

-- Setup null-ls and mason-null-ls
-- Make sure nls is imported *after* lsp setup
-- https://github.com/VonHeikemen/lsp-zero.nvim/issues/60#issuecomment-1363800412
require("config.nlsp.null_ls").setup_null_ls(get_custom_server_opts("null_ls"))

-- Setup crates.nvim for cargo.toml files
require("crates").setup()

-- make sure diagnostics are setup after lsp.setup()
require("config.nlsp.diagnostics").setup_config_diagnostics()

require("config.nlsp.autopairs").setup_autopairs()

require("fidget").setup()

require("lspsaga").setup({
  ui = {
    title = false,
  },
  code_action = {
    keys = {
      quit = { "q", "<ESC>" },
    },
  },
  lightbulb = {
    enable = false,
  },
  rename = {
    quit = "<ESC>",
  },
})
