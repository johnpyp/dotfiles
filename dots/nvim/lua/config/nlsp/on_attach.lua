---@class nlsp.OnAttach
local M = {}

---@class nlsp.attach.Ctx
---@field map fun(mode: string, keys: string, func: fun() | string, desc?: string)

---@alias nlsp.attach.AttachCtxFn fun(client: any, bufnr: number, ctx: nlsp.attach.Ctx)

---@type nlsp.attach.AttachCtxFn
function M.common_on_attach(client, bufnr, ctx)
  -- Delegate typical key configuration to nlsp.keys
  require("config.nlsp.keys").attach_keybinds(client, bufnr, ctx)
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
