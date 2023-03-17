require("config.nlsp.mason").setup_mason_ui()

local lsp = require("lsp-zero")

lsp.preset("lsp-compe")

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

require("config.nlsp.cmp").setup_cmp()
require("config.nlsp.cmp").setup_cmp_highlights()

local custom_settings = require("config.nlsp.settings")

lsp.configure("jsonls", custom_settings.jsonls)
lsp.configure("pyright", custom_settings.pyright)
lsp.configure("tsserver", custom_settings.tsserver)

require("neodev").setup()

local rust_lsp_opts = lsp.build_options("rust_analyzer", custom_settings.rust_analyzer)
local null_opts = lsp.build_options("null-ls", {})

lsp.setup()

-- Initialize rust_analyzer with rust-tools
require("rust-tools").setup({

  -- inlay_hints = {

  --   --     -- Only show inlay hints for the current line
  --   --     only_current_line = false,

  --   --     -- Event which triggers a refersh of the inlay hints.
  --   --     -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
  --   --     -- not that this may cause  higher CPU usage.
  --   --     -- This option is only respected when only_current_line and
  --   --     -- autoSetHints both are true.
  --   --     only_current_line_autocmd = "CursorHold",

  --   --     -- wheter to show parameter hints with the inlay hints or not
  --   --     show_parameter_hints = true,

  --   --     -- prefix for parameter hints
  --   parameter_hints_prefix = "  <-  ",

  --   --     -- prefix for all the other hints (type, chaining)
  --   other_hints_prefix = "  =>  ",

  --   --     -- whether to align to the length of the longest line in the file
  --   -- max_len_align = true,

  --   --     -- padding from the left if max_len_align is true
  --   -- max_len_align_padding = 10,

  --   --     -- whether to align to the extreme right or not
  --   --     right_align = false,

  --   --     -- padding from the right if right_align is true
  --   --     right_align_padding = 7,

  --   --     -- The color of the hints
  --   highlight = "LspCodeLens",
  -- },
  server = rust_lsp_opts,
})

-- Setup crates.nvim for cargo.toml files
require("crates").setup()

-- make sure diagnostics are setup after lsp.setup()
require("config.nlsp.diagnostics").setup_config_diagnostics()

-- Make sure nls is imported *after* lsp setup
-- https://github.com/VonHeikemen/lsp-zero.nvim/issues/60#issuecomment-1363800412

require("config.nlsp.null_ls").setup_null_ls(null_opts)

require("config.nlsp.autopairs").setup_autopairs()

require("fidget").setup()
