-- default mappings
local list = {
  { key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
  { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
  { key = "<C-v>", action = "vsplit" },
  { key = "<C-x>", action = "split" },
  { key = "<C-t>", action = "tabnew" },
  { key = "<", action = "prev_sibling" },
  { key = ">", action = "next_sibling" },
  { key = "u", action = "parent_node" },
  { key = { "<BS>", "h" }, action = "close_node" },
  { key = "<Tab>", action = "preview" },
  { key = "K", action = "first_sibling" },
  { key = "J", action = "last_sibling" },
  { key = "H", action = "toggle_git_ignored" },
  { key = ".", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  { key = "a", action = "create" },
  { key = "D", action = "remove" },
  -- { key = "D", action = "trash" },
  { key = "r", action = "rename" },
  { key = "<C-r>", action = "full_rename" },
  { key = "x", action = "cut" },
  { key = "yy", action = "copy" },
  { key = "p", action = "paste" },
  { key = "yn", action = "copy_name" },
  { key = "yp", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "[c", action = "prev_git_item" },
  { key = "]c", action = "next_git_item" },
  { key = "-", action = "dir_up" },
  { key = "s", action = "system_open" },
  { key = "q", action = "close" },
  { key = "g?", action = "toggle_help" },
}

require("nvim-tree").setup {
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    custom = { ".git", "node_modules", ".cargo" },
  },
  view = {
    side = "right",
    width = 40,
    mappings = {
      custom_only = true,
      list = list,
    },
  },

  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

-- Close nvim-tree when it is the last buffer remaining
-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
  local t = 0
  for _, v in pairs(bufs) do
    if v.name:match "NvimTree_" == nil then t = t + 1 end
  end
  return t
end

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if
      #vim.api.nvim_list_wins() == 1
      and vim.api.nvim_buf_get_name(0):match "NvimTree_" ~= nil
      and modifiedBufs(vim.fn.getbufinfo { bufmodified = 1 }) == 0
    then
      vim.cmd "quit"
    end
  end,
})
