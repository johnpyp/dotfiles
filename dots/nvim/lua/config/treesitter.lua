require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  -- nvim-ts-autotag
  autotag = { enable = true },
  -- nvim-treesitter-endwise
  endwise = { enable = true },
  highlight = { enable = true, use_languagetree = true, additional_vim_regex_highlighting = { "kotlin" } },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },
})

require("nvim-treesitter.parsers").get_parser_configs().just = {
  install_info = {
    url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
    -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
  },
  maintainers = { "@IndianBoy42" },
}
