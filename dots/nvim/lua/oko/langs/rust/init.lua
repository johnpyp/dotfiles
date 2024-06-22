-- Ported & adjusted from:
-- https://github.com/AstroNvim/astrocommunity/blob/c95fc1b58ffbff4381b7c546e8aa8f913cd33c98/lua/astrocommunity/pack/rust/init.lua

---@type LazySpec
return {
  { import = "oko.langs.toml" },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      handlers = { rust_analyzer = false }, -- disable setup of `rust_analyzer`
      ---@diagnostic disable: missing-fields
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
                extraArgs = {
                  "--no-deps",
                },
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate",
              },
              completion = {
                postfix = {
                  enable = false, -- Disables some of the more annoying snippets
                },
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = true,
                  useParameterNames = true,
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = "rust" }
  },
  -- Remove codelldb, which I don't use
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "codelldb" })
  --   end,
  -- },
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "codelldb" })
  --   end,
  -- },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
    opts = function()
      -- local adapter
      -- local success, package = pcall(function() return require("mason-registry").get_package("codelldb") end)
      -- local cfg = require("rustaceanvim.config")
      -- if success then
      --   local package_path = package:get_install_path()
      --   local codelldb_path = package_path .. "/codelldb"
      --   local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
      --   local this_os = vim.loop.os_uname().sysname

      --   -- The path in windows is different
      --   if this_os:find("Windows") then
      --     codelldb_path = package_path .. "\\extension\\adapter\\codelldb.exe"
      --     liblldb_path = package_path .. "\\extension\\lldb\\bin\\liblldb.dll"
      --   else
      --     -- The liblldb extension is .so for linux and .dylib for macOS
      --     liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
      --   end
      --   adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
      -- else
      --   adapter = cfg.get_codelldb_adapter()
      -- end

      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts("rust_analyzer")) or {}
      local server = {
        ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table) -- The rust-analyzer settings or a function that creates them.
        settings = function(project_root, default_settings)
          local astrolsp_settings = astrolsp_opts.settings or {}

          local merge_table = vim.tbl_extend("force", default_settings or {}, astrolsp_settings)
          local ra = require("rustaceanvim.config.server")
          -- load_rust_analyzer_settings merges any found settings with the passed in default settings table and then returns that table
          return ra.load_rust_analyzer_settings(project_root, {
            settings_file_pattern = "rust-analyzer.json",
            default_settings = merge_table,
          })
        end,
      }
      local final_server = vim.tbl_extend("force", astrolsp_opts, server)
      return {
        server = final_server,
        tools = {
          float_win_config = {
            border = "rounded",
          },
          enable_clippy = true,
        },
      }
    end,
    config = function(_, opts) vim.g.rustaceanvim = opts end,
  },
  {
    "Saecki/crates.nvim",
    -- lazy = true,
    -- dependencies = {
    --   "AstroNvim/astrocore",
    --   opts = {
    --     autocmds = {
    --       CmpSourceCargo = {
    --         {
    --           event = "BufRead",
    --           desc = "Load crates.nvim into Cargo buffers",
    --           pattern = "Cargo.toml",
    --           callback = function()
    --             require("cmp").setup.buffer({ sources = { { name = "crates" } } })
    --             require("crates")
    --           end,
    --         },
    --       },
    --     },
    --   },
    -- },
    opts = {
      completion = {
        cmp = { enabled = false },
      },
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      local rustaceanvim_avail, rustaceanvim = pcall(require, "rustaceanvim.neotest")
      if rustaceanvim_avail then table.insert(opts.adapters, rustaceanvim) end
    end,
  },
}
