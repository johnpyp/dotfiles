local M = {}

M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

function M.cmp_format()
  local menu_icon = {
    nvim_lsp = "λ",
    luasnip = "⋗",
    buffer = "Ω",
    path = "🖫",
    nvim_lua = "Π",
  }

  return function(entry, vim_item)
    if M.icons[vim_item.kind] then vim_item.kind = M.icons[vim_item.kind] .. vim_item.kind end

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
