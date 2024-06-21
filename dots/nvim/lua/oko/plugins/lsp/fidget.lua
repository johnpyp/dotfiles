---@type LazySpec
return {
  "j-hui/fidget.nvim",
  opts = {
    notification = {
      poll_rate = 100,
    },
    progress = {

      -- Clear notification group when LSP server detaches
      clear_on_detach = function(client_id)
        local client = vim.lsp.get_client_by_id(client_id)
        return client and client.name or nil
      end,
    },
    -- options
  },
}
