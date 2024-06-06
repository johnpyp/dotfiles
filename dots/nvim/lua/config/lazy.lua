local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function() require("config.theme") end,
  },
  { "mhinz/vim-startify", lazy = false },
  {
    "akinsho/bufferline.nvim",
    branch = "main",
    -- commit = "f6f00d9ac1a51483ac78418f9e63126119a70709",
    lazy = false,
    dependencies = {
      "catppuccin/nvim",
    },
    config = function() require("config.bufferline") end,
  },
  { "nvim-lualine/lualine.nvim", lazy = false, config = function() require("config.lualine") end },
  "lewis6991/impatient.nvim",
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function() vim.g.startuptime_tries = 10 end,
  },
  { "nathom/filetype.nvim", lazy = false, config = function() require("config.filetype") end },
  { "airblade/vim-rooter", lazy = false },
  "numToStr/Comment.nvim",
  "svermeulen/vimpeccable",
  { "echasnovski/mini.nvim", branch = "stable" },
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "udalov/kotlin-vim",
  "NoahTheDuke/vim-just",
  "edgedb/edgedb-vim",
  { "kyazdani42/nvim-web-devicons", lazy = true },
  {
    "stevearc/dressing.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  "saecki/crates.nvim",
  "nvim-treesitter/nvim-treesitter",
  "yioneko/vim-tmindent",
  "RRethy/nvim-treesitter-endwise",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "kyazdani42/nvim-tree.lua",
  "lewis6991/gitsigns.nvim",
  { "folke/which-key.nvim", lazy = true },

  { "junegunn/fzf", run = "./install --bin" },
  "ibhagwan/fzf-lua",
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "hrsh7th/vim-vsnip",
  --     "hrsh7th/vim-vsnip-integ",
  --     "rafamadriz/friendly-snippets",
  --   },
  --   build = "make install_jsregexp",
  --   config = function() require("config.snippets") end,
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        move_cursor = false,
      })
    end,
  },
  "kdheepak/lazygit.nvim",
  "Th3Whit3Wolf/one-nvim",
  "b0o/schemastore.nvim",
  "smjonas/inc-rename.nvim",
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim" },
      -- LSP Support
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Formatters / linters / etc.
      { "jose-elias-alvarez/null-ls.nvim" },
      { "jayp0521/mason-null-ls.nvim" },

      -- Coq autocompletion (testing it out)
      --
      { "ms-jpq/coq_nvim", branch = "coq" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-path" },
      -- { "saadparwaiz1/cmp_luasnip" },
      { "ray-x/cmp-treesitter" },

      -- Copilot
      { "zbirenbaum/copilot.lua" },
      { "zbirenbaum/copilot-cmp" },

      -- Snippets
      -- { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      {
        "garymjr/nvim-snippets",
        config = function()
          require("snippets").setup({
            create_cmp_source = true,
            friendly_snippets = true,
            extended_filetypes = {
              typescript = { "tsdoc" },
              javascript = { "jsdoc" },
              lua = { "luadoc" },
              rust = { "rustdoc" },
              kotlin = { "kdoc" },
            },
          })
        end,
      },

      -- LSP supplements
      { "alaviss/nim.nvim" },
      -- { "folke/neodev.nvim" },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- Library items can be absolute paths
            -- "~/projects/my-awesome-lib",
            -- Or relative, which means they will be resolved as a plugin
            -- "LazyVim",
            -- When relative, you can also provide a path to the library in the plugin dir
            "luvit-meta/library", -- see below
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
      { "jmederosalvarado/roslyn.nvim" },

      {
        "mrcjkb/rustaceanvim",
        version = "^4", -- Recommended
        lazy = false, -- This plugin is already lazy
      },
      -- { "simrat39/rust-tools.nvim" },
      { "sigmasd/deno-nvim" },

      -- LSP UI-related
      { "folke/lsp-colors.nvim" },
      { "folke/trouble.nvim" },
      { "j-hui/fidget.nvim", tag = "legacy" }, -- LSP progressbars / loaders
      { "onsails/lspkind.nvim" },
      { "ray-x/lsp_signature.nvim" },
      { "glepnir/lspsaga.nvim" },
      { "jinzhongjia/LspUI.nvim" },
      { "weilbith/nvim-code-action-menu" },
    },
    lazy = false,
    config = function() require("config.nlsp") end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  "lewis6991/hover.nvim",
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
  },
  "danymat/neogen",
}, {
  root = vim.fn.stdpath("data") .. "/lazy",
  colorscheme = { "catppuccin", "habamax" },
})
