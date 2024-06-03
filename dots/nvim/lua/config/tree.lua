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

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local function toggle_all_filter()
    api.tree.toggle_gitignore_filter()
    -- api.tree.toggle_hidden_filter() (I don't hide dotfiles anyways)
    api.tree.toggle_custom_filter()
  end

  -- Default mappings not inserted as:
  --  remove_keymaps = true
  --  OR
  --  view.mappings.custom_only = true

  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
  vim.keymap.set("n", "u", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  -- vim.keymap.set("n", "H", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
  vim.keymap.set("n", ".", toggle_all_filter, opts("Toggle Dotfiles"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "yp", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", ".cargo" },
  },
  view = {
    side = "right",
    width = 40,
  },
  diagnostics = {
    enable = true,
  },
  -- renderer = {
  --   diagnostics = {
  --     enable = true,
  --   },
  -- },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

-- -- Close nvim-tree when it is the last buffer remaining
-- -- nvim-tree is also there in modified buffers so this function filter it out
-- local modifiedBufs = function(bufs)
--   local t = 0
--   for _, v in pairs(bufs) do
--     if v.name:match("NvimTree_") == nil then t = t + 1 end
--   end
--   return t
-- end

-- vim.api.nvim_create_autocmd("BufEnter", {
--   nested = true,
--   callback = function()
--     if
--       #vim.api.nvim_list_wins() == 1
--       and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
--       and modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0
--     then
--       vim.cmd("quit")
--     end
--   end,
-- })
local function tab_win_closed(winnr)
  local api = require("nvim-tree.api")
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else -- else closed buffer was normal buffer
    if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
        vim.schedule(function()
          if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
            vim.cmd("quit") -- then close all of vim
          else -- else there are more tabs open
            vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
          end
        end)
      end
    end
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true,
})
