local custom_luasnip_jumpable = require("util.luasnip-jumpable").jumpable
local lspkind = require("lspkind")
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Copilot icon
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

---@class nlsp.Cmp
local M = {}

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
-- local has_words_before = function()
--   if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- end
--

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local has_words_before = function()
  local unpack = unpack or table.unpack
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_mapper = require("cmp.types").lsp.CompletionItemKind

local kind_score = {
  Variable = 1,
  Class = 2,
  Enum = 3,
  Property = 4,
  Field = 5,
  Method = 6,
  Struct = 7,
  Keyword = 8,
}

local global_confirm_opts = {
  behavior = cmp.ConfirmBehavior.Replace,
  select = false,
}
---@param ok_luasnip boolean
local get_mappings = function(ok_luasnip)
  local select_opts = { behavior = cmp.SelectBehavior.Select }
  local result = {
    -- confirm selection
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local confirm_opts = vim.deepcopy(global_confirm_opts) -- avoid mutating the original opts below
        local is_insert_mode = function() return vim.api.nvim_get_mode().mode:sub(1, 1) == "i" end
        if is_insert_mode() then                               -- prevent overwriting brackets
          confirm_opts.behavior = cmp.ConfirmBehavior.Insert
        end
        local entry = cmp.get_selected_entry()
        local is_copilot = entry and entry.source.name == "copilot"
        if is_copilot then
          confirm_opts.behavior = cmp.ConfirmBehavior.Replace
          confirm_opts.select = true
        end
        if cmp.confirm(confirm_opts) then
          return -- success, exit early
        end
      end
      fallback() -- if not exited early, always fallback
    end),
    ["<C-y>"] = cmp.mapping.confirm({ select = false }),

    -- navigate items on the list
    ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
    ["<Down>"] = cmp.mapping.select_next_item(select_opts),
    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

    -- scroll up and down in the completion documentation
    ["<C-f>"] = cmp.mapping.scroll_docs(5),
    ["<C-u>"] = cmp.mapping.scroll_docs(-5),

    -- toggle completion
    ["<C-e>"] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end),

    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif custom_luasnip_jumpable(1) then
        luasnip.jump(1)
      elseif has_words_before() then
        fallback()
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
  }

  if ok_luasnip then
    -- go to next placeholder in the snippet
    result["<C-d>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" })

    -- go to previous placeholder in the snippet
    result["<C-b>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  end

  return result
end

---Setup nvim_cmp mappings, sources, window, etc.
function M.setup_cmp()
  cmp.setup({
    enabled = true,
    mapping = get_mappings(true),
    preselect = cmp.PreselectMode.Item,
    -- completion = {
    --   completeopt = "menu,menuone,noinsert",
    -- },
    performance = {
      debounce = 30,
      throttle = 15,

      max_view_entries = 100,
    },
    window = {
      -- bordered completion kinda ugly tho
      -- completion = cmp.config.window.bordered({
      --   border = "single",
      --   side_padding = 0,
      -- }),
      documentation = cmp.config.window.bordered(),
    },

    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    sources = cmp.config.sources(
      {
        -- Copilot Source
        -- { name = "copilot", max_item_count = 3 },
        {
          name = "nvim_lsp",
          max_item_count = 100,
          entry_filter = function(entry, context)
            local kind = entry:get_kind()
            local line = context.cursor_line
            local col = context.cursor.col

            local char_before_cursor = string.sub(line, col - 1, col - 1)
            local char_after_dot = string.sub(line, col, col)

            if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
              if kind == kind_mapper["Method"] or kind == kind_mapper["Field"] or kind == kind_mapper["Property"] then
                return true
              else
                return false
              end
            end

            return true
          end,
        },
        { name = "luasnip", max_item_count = 5, keyword_length = 1 },
        { name = "path" },
        { name = "buffer",  max_item_count = 5, keyword_length = 1 },
        { name = "nvim_lua" },
        -- { name = "treesitter", max_item_count = 3, keyword_length = 1 },
        { name = "crates" },
      }
    -- {
    --   { name = "buffer", keyword_length = 3, max_item_count = 5 },
    -- }
    ),
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

        -- if vim.tbl.contains({ "tree"})
        local menu_text = {
          nvim_lsp = "LSP",
          luasnip = "SNIPPET",
          buffer = "BUFFER",
          path = "PATH",
          nvim_lua = "LUA",
          treesitter = "TREE",
        }

        return lspkind.cmp_format({
          -- symbol_map = require("config.lsp.kind").icons,
          preset = "codicons",
          mode = "symbol_text",
          menu = menu_text,
        })(entry, vim_item)
      end,
    },

    sorting = {
      priority_weight = 2,
      comparators = {
        -- require("copilot_cmp.comparators").prioritize,

        cmp.config.compare.exact,
        cmp.config.compare.offset,
        cmp.config.compare.score,
        cmp.config.compare.locality,

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
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
  })
end

---Apply custom "highlights" (styling/colors) to cmp
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

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end

return M
