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
    config = function() vim.cmd.colorscheme("catppuccin") end,
  },
  { "mhinz/vim-startify", lazy = false },
  { "akinsho/bufferline.nvim", lazy = false },
  { "nvim-lualine/lualine.nvim", lazy = false },
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
  { "kyazdani42/nvim-web-devicons", lazy = true },
  {
    "stevearc/dressing.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  "saecki/crates.nvim",
  "nvim-treesitter/nvim-treesitter",
  "RRethy/nvim-treesitter-endwise",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "kyazdani42/nvim-tree.lua",
  "lewis6991/gitsigns.nvim",
  { "folke/which-key.nvim", lazy = true },

  { "junegunn/fzf", run = "./install --bin" },
  "ibhagwan/fzf-lua",
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "rafamadriz/friendly-snippets",
    },
    config = function() require("config.snippets") end,
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

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },

      -- Copilot
      { "zbirenbaum/copilot.lua" },
      { "zbirenbaum/copilot-cmp" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      -- LSP supplements
      { "alaviss/nim.nvim" },
      { "folke/neodev.nvim" },
      { "jose-elias-alvarez/typescript.nvim" },
      { "simrat39/rust-tools.nvim" },
      { "sigmasd/deno-nvim" },

      -- LSP UI-related
      { "folke/lsp-colors.nvim" },
      { "folke/trouble.nvim" },
      { "j-hui/fidget.nvim", tag = "legacy" }, -- LSP progressbars / loaders
      { "onsails/lspkind.nvim" },
      { "ray-x/lsp_signature.nvim" },
      -- { "glepnir/lspsaga.nvim" },
      { "glepnir/lspsaga.nvim" },
      { "weilbith/nvim-code-action-menu" },
    },
    lazy = false,
    config = function() require("config.nlsp") end,
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
