local lspkind = require("lspkind")
local lsp = require("lsp-zero")
local cmp = require("cmp")

local M = {}

local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
})

function M.create_cmp_config()
  return {
    sources = {
      { name = "path" },
      { name = "nvim_lsp" },
      { name = "buffer", keyword_length = 3 },
      { name = "luasnip" },
    },
    mapping = cmp_mappings,
    formatting = {
      fields = { "abbr", "kind" },
      -- format = require("config.lsp.kind").cmp_format(),
      format = function(entry, vim_item)
        if vim.tbl_contains({ "path" }, entry.source.name) then
          local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return lspkind.cmp_format({ with_text = false })(entry, vim_item)
      end,
    },
  }
end

return M
