---@class nlsp.Format
local M = {}

---Determines if null_ls has formatter support for a given filetype
---@param ft string
---@return boolean
function M.null_ls_has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

function M.format()
  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  vim.lsp.buf.format({
    async = true,
    timeout_ms = 2000,
    filter = function(client)
      if M.null_ls_has_formatter(ft) then
        return client.name == "null-ls"
      else
        return client.name ~= "null-ls"
      end
    end,
  })
end

vim.api.nvim_create_user_command("Format", function() M.format() end, {})

return M
