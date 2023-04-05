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
