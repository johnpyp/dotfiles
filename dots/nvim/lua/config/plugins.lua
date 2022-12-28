local plugins = {
  -- Plugin manager
  ["wbthomason/packer.nvim"] = {},

  -- Optimiser
  ["lewis6991/impatient.nvim"] = {},

  ["nathom/filetype.nvim"] = {},

  -- Theme
  ["catppuccin/nvim"] = { as = "catppuccin" },

  ["folke/lsp-colors.nvim"] = {},

  -- Rooter
  ["airblade/vim-rooter"] = {},

  -- Comment engine
  ["numToStr/Comment.nvim"] = {},

  -- Vimpeccable
  ["svermeulen/vimpeccable"] = {},

  -- Mini (utils)
  ["echasnovski/mini.nvim"] = { branch = "stable" },

  ["nvim-lua/popup.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = {},

  -- Kotlin syntax highlighting
  ["udalov/kotlin-vim"] = {},

  -- Icons
  ["kyazdani42/nvim-web-devicons"] = {},

  -- Built-in LSP
  ["neovim/nvim-lspconfig"] = {
    -- event = "VimEnter"
  },

  -- LSP manager
  ["folke/neodev.nvim"] = {},
  ["simrat39/rust-tools.nvim"] = {},
  ["jose-elias-alvarez/null-ls.nvim"] = {},
  ["jose-elias-alvarez/nvim-lsp-ts-utils"] = {},
  ["stevearc/dressing.nvim"] = {},
  ["weilbith/nvim-code-action-menu"] = {},
  ["saecki/crates.nvim"] = {},
  ["ray-x/lsp_signature.nvim"] = {},
  ["folke/trouble.nvim"] = {},

  ["hrsh7th/vim-vsnip"] = {},
  ["hrsh7th/vim-vsnip-integ"] = {},

  ["nvim-treesitter/nvim-treesitter"] = {},

  ["kyazdani42/nvim-tree.lua"] = {},
  ["lewis6991/gitsigns.nvim"] = {},
  ["mhinz/vim-startify"] = {},
  ["folke/which-key.nvim"] = {},
  ["junegunn/fzf"] = { run = "./install --bin" },
  ["ibhagwan/fzf-lua"] = {},
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {},

  ["hrsh7th/nvim-cmp"] = {},
  ["hrsh7th/cmp-nvim-lsp"] = {},
  ["hrsh7th/cmp-buffer"] = {},
  ["hrsh7th/cmp-path"] = {},
  ["saadparwaiz1/cmp_luasnip"] = {},
  ["L3MON4D3/LuaSnip"] = {},
  ["rafamadriz/friendly-snippets"] = {},
  ["windwp/nvim-autopairs"] = {},
  -- Statusline & Tabline
  ["akinsho/bufferline.nvim"] = {},
  ["nvim-lualine/lualine.nvim"] = {},
  ["kdheepak/lazygit.nvim"] = {},
  ["Th3Whit3Wolf/one-nvim"] = {},
  ["b0o/schemastore.nvim"] = {},
  ["tami5/lspsaga.nvim"] = {},

  -- Mason: LSP/Linter/Formatter Installer
  ["williamboman/mason.nvim"] = {},
  ["williamboman/mason-lspconfig.nvim"] = {},
  ["jayp0521/mason-null-ls.nvim"] = {},

  -- Better rename plugin with live preview
  ["smjonas/inc-rename.nvim"] = {},

  ["VonHeikemen/lsp-zero.nvim"] = {
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },

  ["onsails/lspkind.nvim"] = {},
  ["j-hui/fidget.nvim"] = {},
  ["folke/noice.nvim"] = {
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
      }
  }


  -- ---------------
  -- ---------------
  -- ---------------
  -- ---------------
  -- ---------------
  -- ---------------
  -- -- Lua functions
  -- ["nvim-lua/plenary.nvim"] = { module = "plenary" },

  -- -- Popup API
  -- ["nvim-lua/popup.nvim"] = {},

  -- -- Indent detection
  -- ["Darazaki/indent-o-matic"] = {
  --   event = "BufReadPost",
  --   config = function() require "configs.indent-o-matic" end,
  -- },

  -- -- Notification Enhancer
  -- ["rcarriga/nvim-notify"] = {
  --   event = "VimEnter",
  --   config = function() require "configs.notify" end,
  -- },

  -- -- Neovim UI Enhancer
  -- ["stevearc/dressing.nvim"] = {
  --   event = "VimEnter",
  --   config = function() require "configs.dressing" end,
  -- },

  -- -- Cursorhold fix
  -- ["antoinemadec/FixCursorHold.nvim"] = {
  --   event = { "BufRead", "BufNewFile" },
  --   config = function() vim.g.cursorhold_updatetime = 100 end,
  -- },

  -- -- Smarter Splits
  -- ["mrjones2014/smart-splits.nvim"] = {
  --   module = "smart-splits",
  --   config = function() require "configs.smart-splits" end,
  -- },

  -- -- Icons
  -- ["kyazdani42/nvim-web-devicons"] = {
  --   event = "VimEnter",
  --   config = function() require "configs.icons" end,
  -- },

  -- -- Bufferline
  -- ["akinsho/bufferline.nvim"] = {
  --   after = "nvim-web-devicons",
  --   config = function() require "configs.bufferline" end,
  -- },

  -- -- Better buffer closing
  -- ["famiu/bufdelete.nvim"] = { cmd = { "Bdelete", "Bwipeout" } },

  -- -- File explorer
  -- ["nvim-neo-tree/neo-tree.nvim"] = {
  --   branch = "v2.x",
  --   module = "neo-tree",
  --   cmd = "Neotree",
  --   requires = { { "MunifTanjim/nui.nvim", module = "nui" } },
  --   setup = function() vim.g.neo_tree_remove_legacy_commands = true end,
  --   config = function() require "configs.neo-tree" end,
  -- },

  -- -- Statusline
  -- ["feline-nvim/feline.nvim"] = {
  --   after = "nvim-web-devicons",
  --   config = function() require "configs.feline" end,
  -- },

  -- -- Parenthesis highlighting
  -- ["p00f/nvim-ts-rainbow"] = { after = "nvim-treesitter" },

  -- -- Autoclose tags
  -- ["windwp/nvim-ts-autotag"] = { after = "nvim-treesitter" },

  -- -- Context based commenting
  -- ["JoosepAlviste/nvim-ts-context-commentstring"] = { after = "nvim-treesitter" },

  -- -- Syntax highlighting
  -- ["nvim-treesitter/nvim-treesitter"] = {
  --   run = ":TSUpdate",
  --   event = { "BufRead", "BufNewFile" },
  --   cmd = {
  --     "TSInstall",
  --     "TSInstallInfo",
  --     "TSInstallSync",
  --     "TSUninstall",
  --     "TSUpdate",
  --     "TSUpdateSync",
  --     "TSDisableAll",
  --     "TSEnableAll",
  --   },
  --   config = function() require "configs.treesitter" end,
  -- },

  -- -- Snippet collection
  -- ["rafamadriz/friendly-snippets"] = { opt = true },

  -- -- Snippet engine
  -- ["L3MON4D3/LuaSnip"] = {
  --   module = "luasnip",
  --   wants = "friendly-snippets",
  --   config = function() require "configs.luasnip" end,
  -- },

  -- -- Completion engine
  -- ["hrsh7th/nvim-cmp"] = {
  --   event = "InsertEnter",
  --   config = function() require "configs.cmp" end,
  -- },

  -- -- Snippet completion source
  -- ["saadparwaiz1/cmp_luasnip"] = {
  --   after = "nvim-cmp",
  --   config = function() astronvim.add_user_cmp_source "luasnip" end,
  -- },

  -- -- Buffer completion source
  -- ["hrsh7th/cmp-buffer"] = {
  --   after = "nvim-cmp",
  --   config = function() astronvim.add_user_cmp_source "buffer" end,
  -- },

  -- -- Path completion source
  -- ["hrsh7th/cmp-path"] = {
  --   after = "nvim-cmp",
  --   config = function() astronvim.add_user_cmp_source "path" end,
  -- },

  -- -- LSP completion source
  -- ["hrsh7th/cmp-nvim-lsp"] = {
  --   after = "nvim-cmp",
  --   config = function() astronvim.add_user_cmp_source "nvim_lsp" end,
  -- },

  -- -- Built-in LSP
  -- ["neovim/nvim-lspconfig"] = { event = "VimEnter" },

  -- -- LSP manager
  -- ["williamboman/nvim-lsp-installer"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require "configs.nvim-lsp-installer"
  --     require "configs.lsp"
  --   end,
  -- },

  -- -- LSP symbols
  -- ["stevearc/aerial.nvim"] = {
  --   module = "aerial",
  --   cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
  --   config = function() require "configs.aerial" end,
  -- },

  -- -- Formatting and linting
  -- ["jose-elias-alvarez/null-ls.nvim"] = {
  --   event = { "BufRead", "BufNewFile" },
  --   config = function() require "configs.null-ls" end,
  -- },

  -- -- Fuzzy finder
  -- ["nvim-telescope/telescope.nvim"] = {
  --   cmd = "Telescope",
  --   module = "telescope",
  --   config = function() require "configs.telescope" end,
  -- },

  -- -- Fuzzy finder syntax support
  -- [("nvim-telescope/telescope-%s-native.nvim"):format(vim.fn.has "win32" == 1 and "fzy" or "fzf")] = {
  --   after = "telescope.nvim",
  --   run = vim.fn.has "win32" ~= 1 and "make" or nil,
  --   config = function() require("telescope").load_extension(vim.fn.has "win32" == 1 and "fzy_native" or "fzf") end,
  -- },

  -- -- Git integration
  -- ["lewis6991/gitsigns.nvim"] = {
  --   event = "BufEnter",
  --   config = function() require "configs.gitsigns" end,
  -- },

  -- -- Start screen
  -- ["goolord/alpha-nvim"] = {
  --   cmd = "Alpha",
  --   module = "alpha",
  --   config = function() require "configs.alpha" end,
  -- },

  -- -- Color highlighting
  -- ["norcalli/nvim-colorizer.lua"] = {
  --   event = { "BufRead", "BufNewFile" },
  --   config = function() require "configs.colorizer" end,
  -- },

  -- -- Autopairs
  -- ["windwp/nvim-autopairs"] = {
  --   event = "InsertEnter",
  --   config = function() require "configs.autopairs" end,
  -- },

  -- -- Terminal
  -- ["akinsho/toggleterm.nvim"] = {
  --   cmd = "ToggleTerm",
  --   module = { "toggleterm", "toggleterm.terminal" },
  --   config = function() require "configs.toggleterm" end,
  -- },

  -- -- Commenting
  -- ["numToStr/Comment.nvim"] = {
  --   module = { "Comment", "Comment.api" },
  --   keys = { "gc", "gb", "g<", "g>" },
  --   config = function() require "configs.Comment" end,
  -- },

  -- -- Indentation
  -- ["lukas-reineke/indent-blankline.nvim"] = {
  --   event = "BufRead",
  --   config = function() require "configs.indent-line" end,
  -- },

  -- -- Keymaps popup
  -- ["folke/which-key.nvim"] = {
  --   module = "which-key",
  --   config = function() require "configs.which-key" end,
  -- },

  -- -- Smooth scrolling
  -- ["declancm/cinnamon.nvim"] = {
  --   event = { "BufRead", "BufNewFile" },
  --   config = function() require "configs.cinnamon" end,
  -- },

  -- -- Smooth escaping
  -- ["max397574/better-escape.nvim"] = {
  --   event = "InsertCharPre",
  --   config = function() require "configs.better_escape" end,
  -- },

  -- -- Get extra JSON schemas
  -- ["b0o/SchemaStore.nvim"] = { module = "schemastore" },

  -- -- Session manager
  -- ["Shatur/neovim-session-manager"] = {
  --   module = "session_manager",
  --   cmd = "SessionManager",
  --   event = "BufWritePost",
  --   config = function() require "configs.session_manager" end,
  -- },
}

-- if astronvim.updater.snapshot then
--   for plugin, options in pairs(astro_plugins) do
--     local pin = astronvim.updater.snapshot[plugin:match "/([^/]*)$"]
--     options.commit = pin and pin.commit or options.commit
--   end
-- end

local execute = vim.api.nvim_command
local function bootstrap_packer(namespace)
  local packer_root = vim.fn.stdpath("data") .. "/packer/" .. namespace
  local install_path = packer_root .. "/pack/packer/start/packer.nvim"

  -- Tell vim to look at the root
  vim.o.packpath = packer_root

  -- Install
  if vim.fn.empty(vim.fn.glob(install_path, nil, nil)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    execute("packadd packer.nvim")
  end

  local conf = {
    package_root = packer_root .. "/pack",
    compile_path = packer_root .. "/packer_compiled.vim",
    display = {
      open_fn = function() return require("packer.util").float({ border = "rounded" }) end,
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
      subcommands = {
        update = "pull --rebase",
      },
    },
    auto_clean = true,
    compile_on_sync = true,
  }

  return conf
end

local packer_conf = bootstrap_packer("custom-lua")
local packer = require("packer")

packer.startup({
  function(use)
    for key, plugin in pairs(plugins) do
      if type(key) == "string" and not plugin[1] then plugin[1] = key end
      use(plugin)
    end
  end,
  config = packer_conf,
})
