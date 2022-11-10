local util = require "util"

local M = {}

-- vim.lsp.handlers["textDocument/hover"] = function(_, method, result)
--   print(vim.inspect(result))
-- end

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    util.info("enabled format on save", "Formatting")
  else
    util.warn("disabled format on save", "Formatting")
  end
end

function M.format()
  local ft = vim.api.nvim_buf_get_option(0, "filetype")
  local nls = require "config.lsp.null-ls"
  if M.autoformat then
    vim.lsp.buf.format {
      timeout_ms = 2000,
      filter = function(client)
        local enable = false
        if nls.has_formatter(ft) then
          enable = client.name == "null-ls"
        else
          enable = not (client.name == "null-ls")
        end

        return enable
      end,
    }
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  local nls = require "config.lsp.null-ls"
  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("config.lsp.formatting").format(bufnr)
      augroup END
    ]]
  end
end

return M
