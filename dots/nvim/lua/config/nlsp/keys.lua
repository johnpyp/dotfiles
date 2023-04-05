local formatting = require("config.nlsp.formatting")

---@class nlsp.Keys
local M = {}

---@class nlsp.ProxyLspCommands
---@field code_action string | function
---@field code_action_range string | function
---@field diagnostics_buf string | function
---@field diagnostics_line string | function
---@field diagnostics_workspace string | function
---@field format string | function
---@field goto_declaration string | function
---@field goto_definition string | function
---@field goto_implementation string | function
---@field goto_references string | function
---@field goto_type_definition string | function
---@field rename string | function
---@field signature_help string | function

---@param type "default" | "saga"
---@return nlsp.ProxyLspCommands
function M.get_lsp_commands(type)
  ---@type nlsp.ProxyLspCommands
  local lsp_commands = {
    code_action = vim.lsp.buf.code_action,
    code_action_range = vim.lsp.buf.code_action,
    diagnostics_buf = vim.diagnostic.setqflist,
    diagnostics_line = vim.diagnostic.open_float,
    diagnostics_workspace = "<cmd>Telescope diagnostics<CR>",
    format = formatting.format,
    goto_declaration = vim.lsp.buf.declaration,
    goto_definition = vim.lsp.buf.definition,
    goto_implementation = vim.lsp.buf.implementation,
    goto_references = "<cmd>Trouble lsp_references<CR>",
    goto_type_definition = vim.lsp.buf.type_definition,
    rename = vim.lsp.buf.rename,
    signature_help = vim.lsp.buf.signature_help,
  }

  if type == "saga" then
    lsp_commands.code_action = "<cmd>Lspsaga code_action<CR>"
    lsp_commands.code_action_range = "<cmd>Lspsaga code_action<CR>"
    lsp_commands.diagnostics_buf = "<cmd>Lspsaga show_buf_diagnostics<CR>"
    lsp_commands.diagnostics_line = "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>"
    lsp_commands.diagnostics_workspace = "<cmd>Lspsaga show_workspace_diagnostics<CR>"
    lsp_commands.rename = "<cmd>Lspsaga rename<CR>"
    return lsp_commands
  end

  return lsp_commands
end

local lsp_commands = M.get_lsp_commands("default")

---@type nlsp.attach.AttachCtxFn
function M.attach_keybinds(client, bufnr, ctx)
  ctx.map("n", "F", lsp_commands.format, "Format")

  -- ctx.map("n", "K", vim.lsp.buf.hover, "Hover Documentation") ----------- Already defined in global keys
  ctx.map("n", "<C-k>", lsp_commands.signature_help, "Signature Documentation")
  ctx.map("i", "<C-k>", lsp_commands.signature_help, "Signature Documentation")

  -- Code
  ctx.map("n", "<leader>ca", lsp_commands.code_action, "Code Action")
  ctx.map("v", "<leader>ca", lsp_commands.code_action_range, "Code Action") -- Range code actionn
  ctx.map("n", "<leader>cd", lsp_commands.diagnostics_line, "Line Diagnostics")
  ctx.map("n", "<leader>cD", lsp_commands.diagnostics_buf, "Buffer Diagnostics")
  ctx.map("n", "<leader>cW", lsp_commands.diagnostics_workspace, "Workspace Diagnostics")
  ctx.map("n", "<leader>cr", lsp_commands.rename, "Rename")

  -- Gotos
  ctx.map("n", "gd", lsp_commands.goto_definition, "Goto Definition")
  ctx.map("n", "gr", lsp_commands.goto_references, "Goto [R]eferences")
  ctx.map("n", "gi", lsp_commands.goto_implementation, "Goto Implementation")
  ctx.map("n", "gt", lsp_commands.goto_type_definition, "Goto Type Definition")

  ctx.map("n", "gD", lsp_commands.goto_declaration, "Goto Declaration")
end

return M
