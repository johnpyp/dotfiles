---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          formatting = {
            format_on_save = {
              enabled = true,
            },
          },
          lsp_handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true }),
            ["textDocument/signatureHelp"] = false, -- set to false to disable any custom handlers
          },
        },
      },
      { "folke/neoconf.nvim", lazy = true, opts = {} },
      "williamboman/mason-lspconfig.nvim", -- MUST be set up before `nvim-lspconfig`
    },
    config = function()
      -- set up servers configured with AstroLSP
      vim.tbl_map(require("astrolsp").lsp_setup, require("astrolsp").config.servers)
    end,
    init = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"
      -- https://github.com/neovim/neovim/issues/12970
      -- I seem to get this error with renaming on rust-analyzer
      vim.lsp.util.apply_text_document_edit = function(text_document_edit, _index, offset_encoding)
        local text_document = text_document_edit.textDocument
        local bufnr = vim.uri_to_bufnr(text_document.uri)
        if offset_encoding == nil then
          vim.notify_once("apply_text_document_edit must be called with valid offset encoding", vim.log.levels.WARN)
        end

        vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
      end
    end,
  },
}
