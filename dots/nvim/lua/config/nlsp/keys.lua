local formatting = require("config.nlsp.formatting")

---@class nlsp.Keys
local M = {}

---@alias KeybindValue string | function

---@class nlsp.ProxyLspCommands
---@field code_action KeybindValue
---@field code_action_range KeybindValue
---@field diagnostics_buf KeybindValue
---@field diagnostics_line KeybindValue
---@field diagnostics_workspace KeybindValue
---@field format KeybindValue
---@field goto_declaration KeybindValue
---@field goto_definition KeybindValue
---@field goto_implementation KeybindValue
---@field goto_references KeybindValue
---@field goto_type_definition KeybindValue
---@field rename KeybindValue
---@field signature_help KeybindValue

---@param preset "default" | "saga"
---@param ft "string"
---@return nlsp.ProxyLspCommands
function M.get_lsp_commands(preset, ft)
  local lsp_commands = {
    code_action = { rust = "<cmd>RustCodeAction<CR>", any = vim.lsp.buf.code_action },
    code_action_range = { rust = "<cmd>RustCodeAction<CR>", any = vim.lsp.buf.code_action },
    diagnostics_buf = vim.diagnostic.setqflist,
    diagnostics_line = vim.diagnostic.open_float,
    diagnostics_workspace = "<cmd>Telescope diagnostics<CR>",
    format = "<cmd>Format<CR>",
    goto_declaration = vim.lsp.buf.declaration,
    goto_definition = vim.lsp.buf.definition,
    goto_implementation = vim.lsp.buf.implementation,
    goto_references = "<cmd>Trouble lsp_references<CR>",
    goto_type_definition = vim.lsp.buf.type_definition,
    rename = vim.lsp.buf.rename,
    signature_help = vim.lsp.buf.signature_help,
  }

  if preset == "saga" then
    lsp_commands.code_action = "<cmd>Lspsaga code_action<CR>"
    lsp_commands.code_action_range = "<cmd>Lspsaga code_action<CR>"
    lsp_commands.diagnostics_buf = "<cmd>Lspsaga show_buf_diagnostics<CR>"
    lsp_commands.diagnostics_line = "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>"
    lsp_commands.diagnostics_workspace = "<cmd>Lspsaga show_workspace_diagnostics<CR>"
    lsp_commands.rename = "<cmd>Lspsaga rename<CR>"
  end

  local computed_commands = {}

  for k, v in pairs(lsp_commands) do
    if type(v) == "table" then
      local fv = v[ft]
      if fv ~= nil then
        computed_commands[k] = fv
      else
        assert(v["any"], "Fallback value should not be nil")
        computed_commands[k] = v["any"]
      end
    end
    if computed_commands[k] == nil then computed_commands[k] = v end
  end

  return computed_commands
end

---@type nlsp.attach.AttachCtxFn
function M.attach_keybinds(client, bufnr, ctx)
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local lsp_commands = M.get_lsp_commands("saga", ft)

  local has_typescript_tools = ft == "typescript"
    or ft == "javascript"
    or ft == "jsx"
    or ft == "tsx"
    or ft == "typescriptreact"
    or ft == "javascriptreact"

  ctx.map("n", "F", lsp_commands.format, "Format")

  ctx.map("n", "<leader>cK", vim.lsp.buf.hover, "Hover Documentation") ----------- Already defined in global keys
  ctx.map("n", "<C-k>", lsp_commands.signature_help, "Signature Documentation")
  ctx.map("i", "<C-k>", lsp_commands.signature_help, "Signature Documentation")

  -- Code
  ctx.map("n", "<leader>ca", lsp_commands.code_action, "Code Action")
  ctx.map("v", "<leader>ca", lsp_commands.code_action_range, "Code Action") -- Range code actionn
  ctx.map("n", "<leader>cd", lsp_commands.diagnostics_line, "Line Diagnostics")
  ctx.map("n", "<leader>cD", lsp_commands.diagnostics_buf, "Buffer Diagnostics")
  ctx.map("n", "<leader>cW", lsp_commands.diagnostics_workspace, "Workspace Diagnostics")
  ctx.map("n", "<leader>cr", lsp_commands.rename, "Rename")

  ctx.map("n", "<leader>cP", ":Copilot panel<CR>", nil, { desc = "Copilot Panel" })
  ctx.map("n", "<leader>cA", require("copilot.panel").accept, nil, { desc = "Accept Suggestion" })

  if has_typescript_tools then
    ctx.map("n", "<leader>co", "<cmd>TSToolsOrganizeImports<CR>", "Organize Imports (TS)")
    ctx.map("n", "gD", "<cmd>TSToolsGoToSourceDefinition<CR>", "Goto Source Definition (TS)")
  else
    ctx.map("n", "gD", lsp_commands.goto_declaration, "Goto Declaration")
  end

  -- Gotos
  ctx.map("n", "gd", lsp_commands.goto_definition, "Goto Definition")
  ctx.map("n", "gr", lsp_commands.goto_references, "Goto [R]eferences")
  ctx.map("n", "gi", lsp_commands.goto_implementation, "Goto Implementation")
  ctx.map("n", "gt", lsp_commands.goto_type_definition, "Goto Type Definition")
end

return M
