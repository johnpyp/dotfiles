---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<C-p>", ":FzfLua files<CR>", desc = "Find Files" }, -- Find files
    { "<C-i>", ":FzfLua live_grep_native<CR>", desc = "Fzf Grep" }, -- Find text in files

    -- TODO: should rethink these
    { "<leader>th", ":FzfLua help_tags<CR>", desc = "Help Tags" },
    { "<leader>tf", ":FzfLua files<CR>", desc = "Find Files" },
    { "<leader>tg", ":FzfLua live_grep_native<CR>", desc = "Live Grep" },
    { "<leader>tc", ":FzfLua colorschemes<CR>", desc = "Colorscheme" },
    { "<leader>tt", ":FzfLua filetypes<CR>", desc = "Set Filetype" },
  },
}
