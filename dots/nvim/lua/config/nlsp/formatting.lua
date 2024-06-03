local lsp_settings = require("config.nlsp.settings")

---@class nlsp.Format
local M = {}

---Determines if null_ls has formatter support for a given filetype
---@param ft string
---@return boolean
function M.should_use_null_ls_format(bufnr, ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  local can_null_ls_format = #available > 0

  local clients = vim.lsp.get_active_clients({ bufnr })

  local is_null_ls_active = false
  local lsp_wants_format = false
  for _, client in pairs(clients) do
    if client.name == "null-ls" then is_null_ls_active = true end
    local settings_config = lsp_settings[client.name]
    if settings_config ~= nil then
      if settings_config.prefer_lsp_formatting and client.supports_method("textDocument/formatting") then
        lsp_wants_format = true
        break
      end
    end
  end

  local null_ls_should_format = can_null_ls_format and is_null_ls_active and not lsp_wants_format
  return null_ls_should_format
end

local banned_lsps = { "jsonls" }

---Format file
---@param bufnr number
---@param async boolean
function M.super_format(bufnr, async)
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  vim.lsp.buf.format({
    async = async,
    timeout_ms = 2000,
    filter = function(client)
      for _, v in pairs(banned_lsps) do
        if v == client.name then return false end
      end

      return true

      -- if M.should_use_null_ls_format(bufnr, ft) then
      --   return client.name == "null-ls"
      -- else
      --   return client.name ~= "null-ls"
      -- end
    end,
  })
end

vim.api.nvim_create_user_command("Format", function() M.super_format(0, true) end, {})

local lspformatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = lspformatting_augroup,
  callback = function(args) M.super_format(args.buf, false) end,
})

return M
