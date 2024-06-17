---@type LazySpec
return {
  {
    "yioneko/vim-tmindent",
    main = "tmindent",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
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
    },
  },
  {
    "yioneko/nvim-yati",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
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
        },
      },
      "yioneko/vim-tmindent",
    },
  },
}
