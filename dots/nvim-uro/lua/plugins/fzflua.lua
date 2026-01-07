---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  opts = {
    -- global_resume = true,
    -- global_resume_query = true,
    winopts = {
      width = 0.95,
      preview = {
        default = "bat",
        horizontal = "right:30%",
      },
    },
    -- fzf_opts = {
    --   -- options are sent as `<left>=<right>`
    --   -- set to `false` to remove a flag
    --   -- set to '' for a non-value flag
    --   -- for raw args use `fzf_args` instead
    --   ["--ansi"] = "",
    --   ["--prompt"] = "> ",
    --   ["--info"] = "inline",
    --   ["--height"] = "100%",
    --   ["--layout"] = "reverse",
    -- },
    -- files = {
    --   multiprocess = true,
    --   previewer = "bat",
    --   git_icons = false, -- Git icons slows down each request on large repos, otherwise performance is fine!
    --   file_icons = true,
    --   color_icons = true,
    --   -- cmd = "rg",
    --   rg_opts = "--color=never --files --follow -g '!.git' -g '!node_modules/' -g '!yarn/'",
    --   fd_opts = "--color=never --type f --hidden --follow --exclude '.git/' --exclude node_modules --exclude .yarn",
    -- },
    grep = {
      previewer = false,
      rg_opts = "--column --line-number --no-heading --color=always --ignore-case --max-columns=512 -g '!*.lock' -g '!pnpm-lock.yaml' -g '!vendor/' --ignore-files",
    },
  },
  keys = {
    { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (Cwd)" },
  },
}

--   init = function(_self)
-- require("fzf-lua").register_ui_select(function(_, items)
--   local min_h, max_h = 0.15, 0.70
--   local h = (#items + 4) / vim.o.lines
--   if h < min_h then
--     h = min_h
--   elseif h > max_h then
--     h = max_h
--   end
--   return {
--     winopts = {
--       height = h,
--       width = 0.60,
--       row = 0.40,
--       on_create = function()
--         local function feedkeys(normal_key, insert_key)
--           vim.keymap.set("n", normal_key, function()
--             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true) or "", "n", true)
--             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(insert_key, true, false, true) or "", "n", true)
--             vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true) or "", "n", true)
--           end, { nowait = true, noremap = true, buffer = vim.api.nvim_get_current_buf() })
--         end
--         feedkeys("j", "<c-n>")
--         feedkeys("k", "<c-p>")
--         feedkeys("f", "<c-f>")
--         feedkeys("b", "<c-b>")
--         feedkeys("q", "<Esc>")
--       end,
--     },
--   }
-- end)
