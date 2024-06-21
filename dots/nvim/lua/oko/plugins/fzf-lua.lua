---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<C-p>",      ":FzfLua files<CR>",            desc = "Find Files" }, -- Find files
    { "<C-i>",      ":FzfLua live_grep_native<CR>", desc = "Fzf Grep" }, -- Find text in files

    -- TODO: should rethink these
    { "<leader>th", ":FzfLua help_tags<CR>",        desc = "Help Tags" },
    { "<leader>tf", ":FzfLua files<CR>",            desc = "Find Files" },
    { "<leader>tg", ":FzfLua live_grep_native<CR>", desc = "Live Grep" },
    { "<leader>tc", ":FzfLua colorschemes<CR>",     desc = "Colorscheme" },
    { "<leader>tt", ":FzfLua filetypes<CR>",        desc = "Set Filetype" },
  },
  lazy = false,
  opts = {
    global_resume = true,
    global_resume_query = true,
    winopts = {
      width = 0.9,
      preview = {
        default = "bat",
        horizontal = "right:50%",
      },
    },
    fzf_opts = {
      -- options are sent as `<left>=<right>`
      -- set to `false` to remove a flag
      -- set to '' for a non-value flag
      -- for raw args use `fzf_args` instead
      ["--ansi"] = "",
      ["--prompt"] = "> ",
      ["--info"] = "inline",
      ["--height"] = "100%",
      ["--layout"] = "reverse",
    },
    files = {
      multiprocess = true,
      fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude .yarn",
    },
    grep = {
      previewer = false,
      rg_opts =
      "--column --line-number --no-heading --color=always --ignore-case --max-columns=512 -g '!yarn.lock' -g '!pnpm-lock.yaml' -g '!vendor/' ",
    },
  },

  init = function(_self)
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
    vim.api.nvim_create_user_command("FzfLuaCodeAction", function()
      require("fzf-lua").lsp_code_actions({
        winopts = {
          relative = "cursor",
          width = 0.6,
          height = 0.6,
          row = 1,
          preview = { vertical = "up:30%" },

          on_create = function()
            local function feedkeys(normal_key, insert_key)
              vim.keymap.set("n", normal_key, function()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true) or "", "n", true)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(insert_key, true, false, true) or "", "n", true)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true) or "", "n", true)
              end, { nowait = true, noremap = true, buffer = vim.api.nvim_get_current_buf() })
            end
            feedkeys("j", "<c-n>")
            feedkeys("k", "<c-p>")
            feedkeys("f", "<c-f>")
            feedkeys("b", "<c-b>")
            feedkeys("q", "<Esc>")
          end,
        },
      })
    end, {})
  end,
}
