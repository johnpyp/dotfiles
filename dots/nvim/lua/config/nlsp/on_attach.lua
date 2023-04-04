---@class nlsp.OnAttach
local M = {}

local formatting = require("config.nlsp.formatting")

---@class nlsp.attach.Ctx
---@field map fun(mode: string, keys: string, func: fun() | string, desc?: string)

---@alias nlsp.attach.AttachCtxFn fun(client: any, bufnr: number, ctx: nlsp.attach.Ctx)

---@type nlsp.attach.AttachCtxFn
function M.common_on_attach(client, bufnr, ctx)
  ctx.map("n", "F", formatting.format, "Format")

  -- ctx.map("n", "K", vim.lsp.buf.hover, "Hover Documentation") ----------- Already defined in global keys
  ctx.map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
  ctx.map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Code
  ctx.map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
  ctx.map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action") -- Range code actionn
  ctx.map("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>", "Line Diagnostics")
  ctx.map("n", "<leader>cD", "<cmd>Lspsaga show_buf_diagnostics<CR>", "Buffer Diagnostics")
  ctx.map("n", "<leader>cW", "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Workspace Diagnostics")
  ctx.map("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", "Rename")

  if client.name == "typescript" or client.name == "tsserver" then
    ctx.map("n", "<leader>co", "<cmd>:TSLspOrganize<CR>", "TS Organize Imports")
    ctx.map("n", "<leader>cR", "<cmd>:TSLspRenameFile<CR>", "TS Rename File")
  end

  -- Gotos
  ctx.map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
  ctx.map("n", "gr", "<cmd>Trouble lsp_references<CR>", "Goto [R]eferences")
  ctx.map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
  ctx.map("n", "gt", vim.lsp.buf.type_definition, "Goto Type Definition")

  ctx.map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

  -- -- Utilize nvim-lsp-ts-utils for typescript code
  -- if client.name == "typescript" or client.name == "tsserver" then
  --   local ts = require("nvim-lsp-ts-utils")
  --   -- vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler
  --   ts.setup({
  --     disable_commands = false,
  --     enable_import_on_completion = true,
  --     import_on_completion_timeout = 5000,
  --     eslint_bin = "eslint_d", -- use eslint_d if possible!
  --     eslint_enable_diagnostics = true,
  --     -- eslint_fix_current = false,
  --     eslint_enable_disable_comments = true,
  --   })

  --   ts.setup_client(client)
  -- end
end

---@param client any
---@param bufnr number
function M.compat_on_attach(client, bufnr)
  local ctx = M.create_context(client, bufnr)
  M.common_on_attach(client, bufnr, ctx)
end

---@param client any
---@param bufnr number
---@return nlsp.attach.Ctx
function M.create_context(client, bufnr)
  local map = function(mode, keys, func, desc, opts)
    if desc then desc = "LSP: " .. desc end

    opts = vim.tbl_deep_extend("force", { noremap = true, silent = true, buffer = bufnr, desc = desc }, opts or {})

    vim.keymap.set(mode, keys, func, opts)
  end

  return {
    map = map,
  }
end

return M
