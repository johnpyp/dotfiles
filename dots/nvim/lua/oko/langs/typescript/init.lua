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
        typescript_deno_switch = {
          {
            event = "LspAttach",
            callback = function(args)
              local bufnr = args.buf
              local curr_client = vim.lsp.get_client_by_id(args.data.client_id)

              if curr_client and curr_client.name == "denols" then
                local clients = (vim.lsp.get_clients or vim.lsp.get_active_clients) {
                  bufnr = bufnr,
                  name = "vtsls",
                }
                for _, client in ipairs(clients) do
                  vim.lsp.stop_client(client.id, true)
                end
              end

              -- if vtsls attached, stop it if there is a denols server attached
              if curr_client and curr_client.name == "vtsls" then
                if next((vim.lsp.get_clients or vim.lsp.get_active_clients) { bufnr = bufnr, name = "denols" }) then
                  vim.lsp.stop_client(curr_client.id, true)
                end
              end
            end,
          }
        }
      },
      handlers = {
        -- Disable tsserver in favor of vtsls
        tsserver = false,
      },
      ---@diagnostic disable: missing-fields
      config = {
        denols = {
          -- adjust deno ls root directory detection
          root_dir = function(...) return require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(...) end,
        },
        vtsls = {
          root_dir = require("lspconfig.util").root_pattern("package.json"),
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
            return { "prettierd", "prettier", stop_after_first = true }
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
        "vtsls", "eslint-lsp", "prettier", "prettierd", "js-debug-adapter", "biome", "eslint_d", "denols"
      }
    }
  },
  -- {
  --   "vuki656/package-info.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = {},
  --   event = "BufRead package.json",
  -- },
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
