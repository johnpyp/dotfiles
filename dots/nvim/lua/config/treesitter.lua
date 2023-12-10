local disabled = { "yaml", "lua" }

require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  -- nvim-ts-autotag
  autotag = { enable = true },
  -- nvim-treesitter-endwise
  endwise = { enable = true },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      if vim.tbl_contains(disabled, lang) then return true end
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then return true end
    end,
    additional_vim_regex_highlighting = { "kotlin" },
  },
  -- Disabled in favor of tmindent
  indent = { enable = false },
  context_commentstring = {
    enable = true,
    -- This should stay as FALSE, otherwise it adds performance overhead. This is taken care of instead by the `Comment` hook
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
    enable_autocmd = false,
  },
})

require("tmindent").setup({
  enabled = function() return true end,
  use_treesitter = function() return true end, -- used to detect different langauge region and comments
  default_rule = {},
  rules = {
    lua = {
      comment = { "--" },
      -- inherit pair rules
      inherit = { "&{}", "&()" },
      -- these patterns are the same as TextMate's
      increase = { "\v<%(else|function|then|do|repeat)>((<%(end|until)>)@!.)*$" },
      decrease = { "^\v<%(elseif|else|end|until)>" },
      unindented = {},
      indentnext = {},
    },
  },
})

-- require("nvim-treesitter.parsers").get_parser_configs().just = {
--   install_info = {
--     url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
--     files = { "src/parser.c", "src/scanner.cc" },
--     branch = "main",
--     -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
--   },
--   maintainers = { "@IndianBoy42" },
-- }
