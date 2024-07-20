-- Ported and adjusted from:
-- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/pack/typescript/init.lua

-- local function decode_json(filename)
--   -- Open the file in read mode
--   local file = io.open(filename, "r")
--   if not file then
--     return false -- File doesn't exist or cannot be opened
--   end

--   -- Read the contents of the file
--   local content = file:read("*all")
--   file:close()

--   -- Parse the JSON content
--   local json_parsed, json = pcall(vim.fn.json_decode, content)
--   if not json_parsed or type(json) ~= "table" then
--     return false -- Invalid JSON format
--   end
--   return json
-- end

local format_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

local M = {}

--- Checks if a Prettier config file exists for the given context
---@param ctx ConformCtx
function M.has_prettier_config(ctx)
  vim.fn.system({ "prettier", "--find-config-path", ctx.filename })
  return vim.v.shell_error == 0
end

function M.has_biome_config(ctx)
  local lsp_util = require("lspconfig.util")
  local root = lsp_util.root_pattern("biome.json", "biome.jsonc")(ctx.filename)
  if root and root ~= vim.env.HOME then return true end
  return false
end

M.has_prettier_config = require("oko.utils").memoize(M.has_prettier_config)
M.has_biome_config = require("oko.utils").memoize(M.has_biome_config)


---@type LazySpec
return {
  -- { import = "astrocommunity.pack.json" },
  -- { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "javascript", "typescript", "tsx", "jsdoc" } }
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      autocmds = {
        eslint_fix_on_save = {
          cond = function(client) return client.name == "eslint" and vim.fn.exists(":EslintFixAll") > 0 end,
          {
            event = "BufWritePost",
            desc = "Fix all eslint errors",
            callback = function() vim.cmd.EslintFixAll() end,
          },
        },
      },
      handlers = {
        -- Disable tsserver in favor of vtsls
        tsserver = false,
      },
      ---@diagnostic disable: missing-fields
      config = {
        vtsls = {
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            vtsls = {
              enableMoveToFileCodeAction = true,
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      -- if not opts.formatters_by_ft then opts.formatters_by_ft = {} end
      -- for _, filetype in ipairs(format_filetypes) do
      --   opts.formatters_by_ft[filetype] = conform_formatter
      -- end
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for _, ft in ipairs(format_filetypes) do
        opts.formatters_by_ft[ft] = function(bufnr)
          if require("conform").get_formatter_info("biome", bufnr).available then
            return { "biome" }
          else
            return { { "prettierd", "prettier" } }
          end
        end
      end

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        condition = function(_, ctx)
          if M.has_biome_config(ctx) then return false end
          return M.has_prettier_config(ctx)
        end,
      }
      opts.formatters.biome = {
        condition = function(_, ctx) return M.has_biome_config(ctx) end,
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "vtsls", "eslint-lsp", "prettier", "prettierd", "js-debug-adapter", "biome", "eslint_d"
      }
    }
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  },
  {
    "yioneko/nvim-vtsls",
    opts = {},
    config = function(_, opts) require("vtsls").config(opts) end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    opts = {},
  },
}
