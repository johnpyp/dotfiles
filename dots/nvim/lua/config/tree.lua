local tree_cb = require("nvim-tree.config").nvim_tree_callback
-- default mappings
local list = {
  { key = { "<CR>", "l", "<2-LeftMouse>" }, cb = tree_cb "edit" },
  { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb "cd" },
  { key = "<C-v>", cb = tree_cb "vsplit" },
  { key = "<C-x>", cb = tree_cb "split" },
  { key = "<C-t>", cb = tree_cb "tabnew" },
  { key = "<", cb = tree_cb "prev_sibling" },
  { key = ">", cb = tree_cb "next_sibling" },
  { key = "u", cb = tree_cb "parent_node" },
  { key = { "<BS>", "h" }, cb = tree_cb "close_node" },
  { key = "<Tab>", cb = tree_cb "preview" },
  { key = "K", cb = tree_cb "first_sibling" },
  { key = "J", cb = tree_cb "last_sibling" },
  { key = "I", cb = tree_cb "toggle_ignored" },
  { key = { "H", "." }, cb = tree_cb "toggle_dotfiles" },
  { key = "R", cb = tree_cb "refresh" },
  { key = "a", cb = tree_cb "create" },
  { key = "D", cb = tree_cb "remove" },
  -- { key = "D", cb = tree_cb("trash") },
  { key = "r", cb = tree_cb "rename" },
  { key = "<C-r>", cb = tree_cb "full_rename" },
  { key = "x", cb = tree_cb "cut" },
  { key = "yy", cb = tree_cb "copy" },
  { key = "p", cb = tree_cb "paste" },
  { key = "yn", cb = tree_cb "copy_name" },
  { key = "yp", cb = tree_cb "copy_path" },
  { key = "gy", cb = tree_cb "copy_absolute_path" },
  { key = "[c", cb = tree_cb "prev_git_item" },
  { key = "]c", cb = tree_cb "next_git_item" },
  { key = "-", cb = tree_cb "dir_up" },
  { key = "s", cb = tree_cb "system_open" },
  { key = "q", cb = tree_cb "close" },
  { key = "g?", cb = tree_cb "toggle_help" },
}
require("nvim-tree").setup {
  auto_close = true,
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
