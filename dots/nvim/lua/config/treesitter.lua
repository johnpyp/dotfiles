require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  -- nvim-ts-autotag
  autotag = { enable = true },
  -- nvim-treesitter-endwise
  endwise = { enable = true },
  highlight = { enable = true, additional_vim_regex_highlighting = { "kotlin" } },
  indent = { enable = true },
  context_commentstring = { enable = true },
  disable = function(lang, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then return true end
  end,
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
