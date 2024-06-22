---@type LazySpec
return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          render = "compact",
          stages = "static",
          timeout = 3500,
        },
      },
      "echasnovski/mini.notify",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = true,
        },
        progress = {
          -- Using fidget.nvim for this instead
          enabled = false,
        },
        -- Messages shown by lsp server
        message = {
          enabled = false,
        },
      },

      messages = {
        enabled = false,
      },

      notify = {
        enabled = true,
      },

      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
      cmdline = {
        view = "cmdline",
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local noice_opts = require("oko.utils").plugin_opts("noice.nvim")
      -- disable the necessary handlers in AstroLSP
      if not opts.lsp_handlers then opts.lsp_handlers = {} end
      if vim.tbl_get(noice_opts, "lsp", "hover", "enabled") ~= false then
        opts.lsp_handlers["textDocument/hover"] = false
      end
      if vim.tbl_get(noice_opts, "lsp", "signature", "enabled") ~= false then
        opts.lsp_handlers["textDocument/signatureHelp"] = false
      end
    end,
  },
}
