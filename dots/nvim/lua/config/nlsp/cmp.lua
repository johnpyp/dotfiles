local lspkind = require("lspkind")
local lsp = require("lsp-zero")
local cmp = require("cmp")
local luasnip = require("luasnip")

local M = {}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
})

local kind_mapper = require("cmp.types").lsp.CompletionItemKind

local kind_score = {
  Variable = 1,
  Class = 2,
  Property = 3,
  Field = 3,
  Method = 4,
  Keyword = 5,
}

function M.setup_cmp()
  local cmp_config = lsp.defaults.cmp_config({
    sources = cmp.config.sources({
      {
        name = "nvim_lsp",
        entry_filter = function(entry, context)
          local kind = entry:get_kind()
          local line = context.cursor_line
          local col = context.cursor.col

          local char_before_cursor = string.sub(line, col - 1, col - 1)

          if char_before_cursor == "." then
            if kind == kind_mapper["Method"] or kind == kind_mapper["Field"] or kind == kind_mapper["Property"] then
              return true
            else
              return false
            end
          end

          return true
        end,
      },
      { name = "luasnip", keyword_length = 1, max_item_count = 5 },
      { name = "path" },
    }, {
      { name = "buffer", keyword_length = 3, max_item_count = 5 },
    }),
    mapping = cmp_mappings,
    formatting = {
      fields = { "abbr", "kind", "menu" },
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
        local menu_text = {
          nvim_lsp = "LSP",
          luasnip = "SNIPPET",
          buffer = "BUFFER",
          path = "PATH",
          nvim_lua = "LUA",
        }

        return lspkind.cmp_format({
          -- symbol_map = require("config.lsp.kind").icons,
          preset = "default",
          mode = "symbol_text",
          menu = menu_text,
        })(entry, vim_item)
      end,
    },

    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,

        function(entry1, entry2)
          local kind1 = kind_mapper[entry1:get_kind()]
          local kind2 = kind_mapper[entry2:get_kind()]

          local kind_score1 = kind_score[kind1] or 100
          local kind_score2 = kind_score[kind2] or 100

          if kind_score1 < kind_score2 then return true end
          if kind_score1 > kind_score2 then return false end
        end,
        -- copied from cmp-under, but I don't think I need the plugin for this.
        -- Properly sorts underscore properties
        -- function(entry1, entry2)
        --   local _, entry1_under = entry1.completion_item.label:find("^_+")
        --   local _, entry2_under = entry2.completion_item.label:find("^_+")
        --   entry1_under = entry1_under or 0
        --   entry2_under = entry2_under or 0
        --   if entry1_under > entry2_under then
        --     return false
        --   elseif entry1_under < entry2_under then
        --     return true
        --   end
        -- end,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })

  cmp.setup(cmp_config)
end

function M.setup_cmp_highlights()
  vim.cmd([[
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

  highlight! link CmpItemMenu CmpItemMenuDefault
]])
end

return M
