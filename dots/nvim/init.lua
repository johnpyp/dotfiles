-- Plugins {{{ --
-- local execute = vim.api.nvim_command
-- local fn = vim.fn

-- local function bootstrap_packer(namespace)
--   local packer_root = vim.fn.stdpath "data" .. "/packer/" .. namespace
--   local install_path = packer_root .. "/pack/packer/start/packer.nvim"

--   -- Tell vim to look at the root
--   vim.o.packpath = packer_root

--   -- Install
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
--     execute "packadd packer.nvim"
--   end

--   local conf = {
--     package_root = packer_root .. "/pack",
--     compile_path = packer_root .. "/packer_compiled.vim",
--     profile = {
--       enable = true,
--       threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
--     },
--   }

--   return conf
-- end

-- local packer_conf = bootstrap_packer "custom-lua"

-- local packer = require "packer"

-- packer.startup {
--   function(use)
--     -- Packer can manage itself
--     use "wbthomason/packer.nvim"
--     use "nathom/filetype.nvim"
--     use {
--       "catppuccin/nvim",
--       as = "catppuccin",
--     }

--     -- Theme
--     use "folke/lsp-colors.nvim"

--     -- Misc
--     use "airblade/vim-rooter"
--     -- use 'b3nj5m1n/kommentary'
--     use "numToStr/Comment.nvim"
--     use "svermeulen/vimpeccable"
--     -- use 'famiu/nvim-reload'

--     use { "echasnovski/mini.nvim", branch = "stable" }
--     -- Telescope
--     -- use 'nvim-telescope/telescope.nvim'
--     use "nvim-lua/popup.nvim"
--     use "nvim-lua/plenary.nvim"
--     -- use({"tjdevries/astronauta.nvim", config = function()
--     -- vim.cmd [[runtime plugin/astronauta.vim]]
--     -- end})
--     -- use {'kevinhwang91/nvim-bqf', ft = 'qf'}

--     -- LSP
--     use "kyazdani42/nvim-web-devicons"
--     use "neovim/nvim-lspconfig"
--     use "williamboman/nvim-lsp-installer"
--     use "folke/neodev.nvim"
--     use "simrat39/rust-tools.nvim"
--     use "jose-elias-alvarez/null-ls.nvim"
--     use "jose-elias-alvarez/nvim-lsp-ts-utils"
--     use "stevearc/dressing.nvim"
--     use "weilbith/nvim-code-action-menu"

--     use "saecki/crates.nvim"
--     -- use("RishabhRD/lspactions")

--     use "ray-x/lsp_signature.nvim"

--     use {
--       "folke/trouble.nvim",
--     }

--     -- use 'neovim/nvim-lspconfig'        -- Collection of configurations for built-in LSP client
--     -- use 'glepnir/lspsaga.nvim'
--     -- use 'kabouzeid/nvim-lspinstall'

--     -- Snippets
--     use "hrsh7th/vim-vsnip"
--     use "hrsh7th/vim-vsnip-integ"

--     -- Tresitter
--     use "nvim-treesitter/nvim-treesitter"
--     -- use 'windwp/nvim-ts-autotag'

--     -- Tree
--     use "kyazdani42/nvim-tree.lua"

--     -- Git
--     use "lewis6991/gitsigns.nvim"

--     -- Start
--     use "mhinz/vim-startify"

--     use "folke/which-key.nvim"

--     -- Icons

--     use { "junegunn/fzf", run = "./install --bin" }
--     use "ibhagwan/fzf-lua"

--     use "JoosepAlviste/nvim-ts-context-commentstring"

--     -- cmp
--     use "hrsh7th/nvim-cmp"
--     use "hrsh7th/cmp-nvim-lsp"
--     use "hrsh7th/cmp-buffer"
--     use "hrsh7th/cmp-path"
--     use "saadparwaiz1/cmp_luasnip"
--     use "L3MON4D3/LuaSnip"
--     use "rafamadriz/friendly-snippets"

--     use "windwp/nvim-autopairs"

--     -- Statusline & Tabline
--     use "akinsho/bufferline.nvim"
--     use "nvim-lualine/lualine.nvim"
--     use "kdheepak/lazygit.nvim"

--     use "Th3Whit3Wolf/one-nvim"
--     use "b0o/schemastore.nvim"

--     use "tami5/lspsaga.nvim"

--     -- use 'jose-elias-alvarez/buftabline.nvim'
--   end,
--   config = packer_conf,
-- }
-- }}} Plugins --
--
--
local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

require("config.plugins")
require("config.general")
require("config.theme")
require("config.keys")
require("config.snippets")
require("config.cmp")
require("config.lsp")
require("config.tree")
require("config.lualine")
require("config.bufferline")
require("config.misc")
require("config.filetype")
