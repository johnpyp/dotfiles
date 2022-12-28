local M = {}

-- From https://github.com/onsails/lspkind.nvim/blob/master/lua/lspkind/init.lua
M.icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

function M.cmp_format()
  local menu_icon = {
    nvim_lsp = 'λ',
    luasnip = '⋗',
    buffer = 'Ω',
    path = '🖫',
    nvim_lua = 'Π',
  }

  return function(entry, vim_item)
    if M.icons[vim_item.kind] then vim_item.kind = M.icons[vim_item.kind] .. " " .. vim_item.kind end

    vim_item.menu = menu_icon[entry.source.name]
    return vim_item
  end
end

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M
