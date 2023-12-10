require("Comment").setup({
  ignore = "^$",
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

require("fzf-lua").setup({
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
    rg_opts = "--column --line-number --no-heading --color=always --ignore-case --max-columns=512 -g '!yarn.lock' -g '!pnpm-lock.yaml' -g '!vendor/' ",
  },
})

require("telescope").setup({})

-- Dressing needs to be explicitly setup with configured backends
-- Otherwise it will default to telescope which meses up code_action :(
require("dressing").setup({
  input = { enabled = false },
  select = {
    enabled = false,
    backend = { "nui", "builtin" },
    nui = {
      win_options = {
        winblend = 0,
      },
    },
    get_config = function(opts)
      if opts.kind == "codeaction" then
        return {
          backend = "nui",
          -- If the position is not set to cursor, then this will be centered
          -- row == 2 to set the window 1 below current line
          nui = {
            position = { row = 2, col = 0 },
            relative = "cursor",
            max_width = 40,
          },
        }
      end
    end,
  },
})

-- local actions = require('telescope.actions')
-- -- Telescope
-- require('telescope').setup {
--   defaults = {
--     mappings = {
--       i = {
-- 	["<C-j>"] = actions.move_selection_next,
-- 	["<C-k>"] = actions.move_selection_previous,
-- 	["<esc>"] = actions.close,
--         ["<C-u>"] = false,
--         ["<C-d>"] = false,
--       },
--     },
--     generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
--     file_sorter =  require'telescope.sorters'.get_fzy_sorter,
--   }
-- }

-- Rooter
vim.g.rooter_change_directory_for_non_project_files = "current"
vim.g.rooter_resolve_links = true
vim.g.rooter_patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", ".project", ".projectkeep" }

require("trouble").setup({
  auto_open = false,
  auto_close = false,
  action_keys = {
    -- map to {} to remove a mapping, for example:
    -- close = {},
    close = "<esc>", -- close the list
    cancel = {}, -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = { "<tab>" }, -- jump to the diagnostic or open / close folds
    open_split = { "<c-x>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    open_tab = { "<c-t>" }, -- open buffer in new tab
    jump_close = { "<cr>" }, -- jump to the diagnostic and close the list
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "K", -- opens a small popup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = { "zM", "zm" }, -- close all folds
    open_folds = { "zR", "zr" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file
    previous = "k", -- preview item
    next = "j", -- next item
  },
})

-- require("mini.surround").setup({
--   -- Number of lines within which surrounding is searched
--   n_lines = 20,

--   -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
--   highlight_duration = 500,

--   -- Pattern to match function name in 'function call' surrounding
--   -- By default it is a string of letters, '_' or '.'
--   -- funname_pattern = "[%w_%.]+",

--   -- Module mappings. Use `''` (empty string) to disable one.
--   mappings = {
--     add = "", -- Add surrounding
--     delete = "ds", -- Delete surrounding
--     find = "", -- Find surrounding (to the right)
--     find_left = "", -- Find surrounding (to the left)
--     highlight = "", -- Highlight surrounding
--     replace = "cs", -- Replace surrounding
--     update_n_lines = "", -- Update `n_lines`
--   },
-- })

require("inc_rename").setup()

require("hover").setup({
  init = function()
    -- Require providers
    require("hover.providers.lsp")
    -- require("hover.providers.gh")
    -- require('hover.providers.gh_user')
    -- require('hover.providers.jira')
    require("hover.providers.man")
    -- require("hover.providers.dictionary")
  end,
  preview_opts = {
    border = "rounded",
  },
  -- Whether the contents of a currently open hover window should be moved
  -- to a :h preview-window when pressing the hover keymap.
  preview_window = false,
  title = false,
})

require("hover").register({
  name = "Crates LSP",
  enabled = function() return vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() end,
  execute = function() require("crates").show_popup() end,
  priority = 1200,
})
