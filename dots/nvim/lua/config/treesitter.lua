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
  -- Disabled in favor of yati + tmindent
  indent = { enable = false },

  yati = {
    enable = true,
    -- Disable by languages, see `Supported languages`
    -- disable = { "python" },

    -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
    default_lazy = true,

    -- Determine the fallback method used when we cannot calculate indent by tree-sitter
    --   "auto": fallback to vim auto indent
    --   "asis": use current indent as-is
    --   "cindent": see `:h cindent()`
    -- Or a custom function return the final indent result.
    -- default_fallback = "auto"
    default_fallback = function(lnum, computed, bufnr)
      local tm_fts = { "lua", "javascript", "python" }
      if vim.tbl_contains(tm_fts, vim.bo[bufnr].filetype) then
        return require("tmindent").get_indent(lnum, bufnr) + computed
      end
      -- or any other fallback methods
      return require("nvim-yati.fallback").vim_auto(lnum, computed, bufnr)
    end,
  },
})

require("tmindent").setup({
  enabled = function() return false end,
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
