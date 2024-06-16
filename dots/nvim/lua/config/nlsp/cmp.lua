-- local custom_luasnip_jumpable = require("util.luasnip-jumpable").jumpable
local lspkind = require("lspkind")
local cmp = require("cmp")
-- local luasnip = require("luasnip")

-- Copilot icon
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

---@class nlsp.Cmp
local M = {}

local string_contains = function(s, sub) return s:find(sub, 1, true) end

local truncate = function(str, len)
  if not str or #str <= len then return str end

  return str:sub(1, len - 1) .. "…"
end

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
----Helper functions
--- Truncate component to `len` characters
--- @param str string
--- @param len number
--- @return string
M.truncate = function(str, len)
  if #str <= len then return str end

  return str:sub(1, len - 1) .. "…"
end

local kind_mapper = require("cmp.types").lsp.CompletionItemKind

local kind_score = {
  EnumMember = 10,
  Variable = 20,
  Class = 30,
  Enum = 40,
  Property = 50,
  Field = 60,
  Method = 70,
  Struct = 80,
  Function = 90,
  Keyword = 100,
}

local types = require("cmp.types")
local modified_priority = {
  [types.lsp.CompletionItemKind.Field] = types.lsp.CompletionItemKind.Method,
  [types.lsp.CompletionItemKind.Property] = types.lsp.CompletionItemKind.Method,
  [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,

  [types.lsp.CompletionItemKind.Struct] = types.lsp.CompletionItemKind.Class,
  [types.lsp.CompletionItemKind.Enum] = types.lsp.CompletionItemKind.Class,
  [types.lsp.CompletionItemKind.EnumMember] = types.lsp.CompletionItemKind.Class,

  [types.lsp.CompletionItemKind.Snippet] = 100, -- bottom
  [types.lsp.CompletionItemKind.Keyword] = 100, -- bottom
  [types.lsp.CompletionItemKind.Text] = 100, -- bottom
}
---@param kind integer: kind of completion entry
local function modified_kind(kind) return modified_priority[kind] or kind end

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
        if is_insert_mode() then -- prevent overwriting brackets
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
      elseif vim.snippet.active({ direction = 1 }) then
        vim.schedule(function() vim.snippet.jump(1) end)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        -- elseif luasnip.jumpable(-1) then
        --   luasnip.jump(-1)
      elseif vim.snippet.active({ direction = -1 }) then
        vim.schedule(function() vim.snippet.jump(-1) end)
      else
        fallback()
      end
    end, { "i", "s" }),
  }

  -- if ok_luasnip then
  --   -- go to next placeholder in the snippet
  --   result["<C-d>"] = cmp.mapping(function(fallback)
  --     if luasnip.jumpable(1) then
  --       luasnip.jump(1)
  --     else
  --       fallback()
  --     end
  --   end, { "i", "s" })

  --   -- go to previous placeholder in the snippet
  --   result["<C-b>"] = cmp.mapping(function(fallback)
  --     if luasnip.jumpable(-1) then
  --       luasnip.jump(-1)
  --     else
  --       fallback()
  --     end
  --   end, { "i", "s" })
  -- end

  return result
end

local sorters = require("config.cmp_utils.sorters")

---Setup nvim_cmp mappings, sources, window, etc.
function M.setup_cmp()
  cmp.setup({
    enabled = true,
    mapping = get_mappings(true),
    preselect = cmp.PreselectMode.None, -- Set to none to avoid flickering pre-selected item
    completion = {
      completeopt = "menu,menuone", -- Remove `noinsert` to avoid flickering pre-selected item
    },
    performance = {
      debounce = 30,
      throttle = 15,

      max_view_entries = 150,
    },
    window = {
      -- bordered completion kinda ugly tho
      -- completion = cmp.config.window.bordered({
      --   border = "single",
      --   side_padding = 0,
      -- }),
      documentation = cmp.config.window.bordered(),
    },

    -- snippet = {
    --   expand = function(args) luasnip.lsp_expand(args.body) end,
    -- },
    sources = cmp.config.sources(
      {
        {
          name = "lazydev",
        },
      },
      {
        -- Copilot Source
        -- { name = "copilot", max_item_count = 3 },
        {
          name = "nvim_lsp",
          max_item_count = 400,
          -- entry_filter = function(entry, context)
          --   local kind = entry:get_kind()
          --   local line = context.cursor_line
          --   local col = context.cursor.col

          --   local char_before_cursor = string.sub(line, col - 1, col - 1)
          --   local char_after_dot = string.sub(line, col, col)

          --   if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
          --     if kind == kind_mapper["Method"] or kind == kind_mapper["Field"] or kind == kind_mapper["Property"] then
          --       return true
          --     else
          --       return false
          --     end
          --   end

          --   return true
          -- end,
        },
        { name = "snippets", max_item_count = 5, keyword_length = 1 },
        -- { name = "luasnip", max_item_count = 5, keyword_length = 1 },
        { name = "path" },
        { name = "buffer", max_item_count = 5, keyword_length = 1 },
        -- { name = "nvim_lua" },
        -- { name = "treesitter", max_item_count = 3, keyword_length = 1 },
        { name = "crates" },
      }
      -- {
      --   { name = "buffer", keyword_length = 3, max_item_count = 5 },
      -- }
    ),
    formatting = {
      fields = { "abbr", "kind", "menu" },
      expandable_indicator = true,
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

        -- local max_width = 50
        -- vim_item.abbr = string.sub(vim_item.abbr, 1, max_width)
        -- vim_item.menu = string.sub(vim_item.menu, 1, max_width)
        local max_width
        local cols = vim.o.columns

        if cols > 150 then
          max_width = math.floor(cols * 0.5)
        else
          max_width = math.floor(cols * 0.3)
        end

        if vim_item.menu then
          max_width = max_width
          vim_item.menu = M.truncate(vim_item.menu, max_width)
        end

        vim_item.abbr = M.truncate(vim_item.abbr, max_width)

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
          -- menu = menu_text,
        })(entry, vim_item)
      end,
    },

    sorting = {
      priority_weight = 2,
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        -- cmp.config.compare.kind,

        ---@param e1 cmp.Entry
        ---@param e2 cmp.Entry
        function(e1, e2) -- sort by compare kind (Variable, Function etc)
          local kind1 = modified_kind(e1:get_kind())
          local kind2 = modified_kind(e2:get_kind())

          return sorters.eval.smaller_number_better(kind1, kind2)
        end,

        ---@param e1 cmp.Entry
        ---@param e2 cmp.Entry
        function(e1, e2) -- (rust) deprioritize "owo_colors" from color_eyre
          if not sorters.is_lang_lsp(e1, e2, "rust") then return nil end

          local i1, i2 = sorters.get_infos(e1, e2)

          local bad1 = string_contains(i1.deets, "owo_colors")
          local bad2 = string_contains(i2.deets, "owo_colors")

          return sorters.eval.bad_bools(bad1, bad2)
        end,
        ---@param e1 cmp.Entry
        ---@param e2 cmp.Entry
        function(e1, e2)
          local _, e1_under = e1:get_completion_item().label:find("^_+")
          local _, e2_under = e2:get_completion_item().label:find("^_+")

          e1_under = e1_under or 0
          e2_under = e2_under or 0

          return sorters.eval.smaller_number_better(e1_under, e2_under)
        end,
        cmp.config.compare.recently_used,
        cmp.config.compare.sort_text,
        cmp.config.compare.locality,
        cmp.config.compare.score,
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
