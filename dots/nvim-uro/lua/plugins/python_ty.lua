---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local servers = { "ty" }
      for _, server in ipairs(servers) do
        -- vim.lsp.enable(server)
        -- opts.servers[server] = opts.servers[server] or {}
        -- opts.servers[server].enabled = true
      end
    end,
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
