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
  -- return lsp_utils.search_ancestors(startpath, function(path)
  --   if M.path.is_file(M.path.join(path, 'package.json')) then
  --     return path
  --   end
  -- end)
end

M.has_prettier_config = require("oko.utils").memoize(M.has_prettier_config)
M.has_biome_config = require("oko.utils").memoize(M.has_biome_config)

-- local function check_json_key_exists(json, ...) return vim.tbl_get(json, ...) ~= nil end
-- local lsp_rooter, prettierrc_rooter
-- local has_prettier = function(bufnr)
--   if type(bufnr) ~= "number" then bufnr = vim.api.nvim_get_current_buf() end
--   local rooter = require("astrocore.rooter")
--   if not lsp_rooter then
--     lsp_rooter = rooter.resolve("lsp", {
--       ignore = {
--         servers = function(client)
--           return not vim.tbl_contains({ "vtsls", "typescript-tools", "volar", "eslint", "tsserver" }, client.name)
--         end,
--       },
--     })
--   end
--   if not prettierrc_rooter then
--     prettierrc_rooter = rooter.resolve({
--       ".prettierrc",
--       ".prettierrc.json",
--       ".prettierrc.yml",
--       ".prettierrc.yaml",
--       ".prettierrc.json5",
--       ".prettierrc.js",
--       ".prettierrc.cjs",
--       "prettier.config.js",
--       ".prettierrc.mjs",
--       "prettier.config.mjs",
--       "prettier.config.cjs",
--       ".prettierrc.toml",
--     })
--   end
--   local prettier_dependency = false
--   for _, root in ipairs(require("astrocore").list_insert_unique(lsp_rooter(bufnr), { vim.fn.getcwd() })) do
--     local package_json = decode_json(root .. "/package.json")
--     if
--       package_json
--       and (
--         check_json_key_exists(package_json, "dependencies", "prettier")
--         or check_json_key_exists(package_json, "devDependencies", "prettier")
--       )
--     then
--       prettier_dependency = true
--       break
--     end
--   end
--   return prettier_dependency or next(prettierrc_rooter(bufnr))
-- end

-- local null_ls_formatter = function(params)
--   if vim.tbl_contains(format_filetypes, params.filetype) then return has_prettier(params.bufnr) end
--   return true
-- end

-- local conform_formatter = function(bufnr) return has_prettier(bufnr) and { "prettierd" } or {} end

---@type LazySpec
return {
  -- { import = "astrocommunity.pack.json" },
  -- { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed =
          require("oko.utils").list_insert_unique(opts.ensure_installed, { "javascript", "typescript", "tsx", "jsdoc" })
      end
    end,
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
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("oko.utils").list_insert_unique(opts.ensure_installed, { "prettier" })
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "vtsls", "eslint" })
  --   end,
  -- },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "prettierd" })
  --     if not opts.handlers then opts.handlers = {} end

  --     opts.handlers.prettierd = function(source_name, methods)
  --       local null_ls = require("null-ls")
  --       for _, method in ipairs(methods) do
  --         null_ls.register(null_ls.builtins[method][source_name].with({ runtime_condition = null_ls_formatter }))
  --       end
  --     end
  --   end,
  -- },
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
            return { "biome", { "eslint_d", "eslint" } }
          else
            return { { "prettierd", "prettier" }, { "eslint_d", "eslint" } }
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
    opts = function(_, opts)
      opts.ensure_installed = require("oko.utils").list_insert_unique(
        opts.ensure_installed,
        { "vtsls", "eslint-lsp", "prettier", "prettierd", "js-debug-adapter", "biome", "eslint_d" }
      )
    end,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  },
  {
    "yioneko/nvim-vtsls",
    lazy = true,
    dependencies = {
      -- "AstroNvim/astrocore",
      -- opts = {
      --   autocmds = {
      --     nvim_vtsls = {
      --       {
      --         event = "LspAttach",
      --         desc = "Load nvim-vtsls with vtsls",
      --         callback = function(args)
      --           if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "vtsls" then
      --             require("vtsls")._on_attach(args.data.client_id, args.buf)
      --             vim.api.nvim_del_augroup_by_name("nvim_vtsls")
      --           end
      --         end,
      --       },
      --     },
      --   },
      -- },
    },
    config = function(_, opts) require("vtsls").config(opts) end,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    opts = {},
  },
}
