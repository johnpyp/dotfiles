local valid_severities = {
  "error",
  "warning",
  -- "info",
  -- "hint",
}

---@type LazySpec
return {
  "akinsho/bufferline.nvim",
  lazy = false,
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  },
  opts = function(self, opts)
    local signs = require("oko.utils.signs")

    return {
      options = {
        show_close_icon = true,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        separator_style = "thick",
        diagnostics_indicator = function(_, _, diag)
          local s = {}
          for _, severity in ipairs(valid_severities) do
            if diag[severity] then table.insert(s, signs.severity[severity] .. diag[severity]) end
          end
          return table.concat(s, " ")
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "neo-tree",
            text = "NeoTree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    }
  end,
}
