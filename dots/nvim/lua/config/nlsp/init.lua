require("neoconf").setup()
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
require("config.nlsp.lspconfig-edits")

local custom_settings = require("config.nlsp.settings")

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
  local cmd = nil
  local trace = nil
  local root_dir = nil
  -- local single_file_support = false

  -- Overrides
  if server_name ~= nil and custom_settings[server_name] ~= nil then
    local lsps_settings = custom_settings[server_name]
    capabilities = lsps_settings["capabilities"] or lsp_capabilities
    before_on_attach = lsps_settings["before_on_attach"] or nil
    after_on_attach = lsps_settings["after_on_attach"] or nil
    settings = lsps_settings["settings"] or {}
    cmd = lsps_settings["cmd"] or nil
    trace = lsps_settings["trace"] or nil
    root_dir = lsps_settings["root_dir"] or nil
    -- single_file_support = lsps_settings["single_file_support"] or false
  end

  local combined_on_attach = function(client, bufnr)
    local ctx = my_on_attach.create_context(client, bufnr)
    if before_on_attach ~= nil then before_on_attach(client, bufnr, ctx) end
    my_on_attach.common_on_attach(client, bufnr, ctx)
    if after_on_attach ~= nil then after_on_attach(client, bufnr, ctx) end
  end

  return {
    root_dir = root_dir,
    on_attach = combined_on_attach,
    -- single_file_support = single_file_support,
    capabilities = capabilities,
    settings = settings,
    flags = flags,
    cmd = cmd,
    trace = trace,
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
    "lua_ls",
    "pyright",
    "rust_analyzer",
    -- "tsserver",
    "denols",
  },
  automatic_installation = true,
})

-- Hack to disable tsserver in deno project
lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
  local cwd = vim.loop.cwd()
  if config.name == "tsserver" and vim.fn.filereadable(cwd .. "/deno.json") == 1 then
    config.single_file_support = false
  end
end)

-- Appropriately highlight code references returned from Deno
-- vim.g.markdown_fenced_languages = {
--   "ts=typescript",
-- }

local disabled = { "rome", "tsserver" }
require("mason-lspconfig").setup_handlers({
  function(server_name)
    for _, v in pairs(disabled) do
      if v == server_name then return end
    end

    local opts = get_custom_server_opts(server_name)
    lspconfig[server_name].setup(opts)
  end,
  ["jsonls"] = custom_setup_wrapper("jsonls"),
  ["lua_ls"] = custom_setup_wrapper("lua_ls"),
  -- ["v-analyzer"] = custom_setup_wrapper("v-analyzer"),
  ["pyright"] = custom_setup_wrapper("pyright"),
  ["rust_analyzer"] = function()
    require("rust-tools").setup({
      server = get_custom_server_opts("rust_analyzer"),
    })
  end,
  -- ["tsserver"] = function()
  --   require("typescript").setup({
  --     server = get_custom_server_opts("tsserver"),
  --   })
  -- end,
  ["denols"] = function()
    require("deno-nvim").setup({
      server = get_custom_server_opts("denols"),
    })
  end,
})

require("config.nlsp.lspconfig-edits")
-- lspconfig["v-analyzer"].setup({})

require("typescript-tools").setup({
  on_attach = get_custom_server_opts("tsserver").on_attach,

  settings = {
    tsserver_file_preferences = {
      importModuleSpecifierPreference = "project-relative",
    },

    tsserver_plugins = {
      "@styled/typescript-styled-plugin",
    },
  },
  -- handlers = { ... },
  -- ...
  -- DEFAULTS
  -- settings = {
  --   -- spawn additional tsserver instance to calculate diagnostics on it
  --   separate_diagnostic_server = true,
  --   -- "change"|"insert_leave" determine when the client asks the server about diagnostic
  --   publish_diagnostic_on = "insert_leave",
  --   -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
  --   -- specify commands exposed as code_actions
  --   expose_as_code_action = {},
  --   -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
  --   -- not exists then standard path resolution strategy is applied
  --   tsserver_path = nil,
  --   -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
  --   -- (see 💅 `styled-components` support section)
  --   tsserver_plugins = {},
  --   -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
  --   -- memory limit in megabytes or "auto"(basically no limit)
  --   tsserver_max_memory = "auto",
  --   -- described below
  --   tsserver_format_options = {},
  --   tsserver_file_preferences = {},
  -- },
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
  symbol_in_winbar = {
    enable = false,
  },
})
