local lspconfig = require "lspconfig"

local M = {}

function M.setup_servers(servers, options)
  -- M.install_missing(servers)
  for server_name, server_opts in pairs(servers) do
    local opts = vim.tbl_deep_extend("force", options, server_opts or {})

    if server_name == "rust_analyzer" then
      -- opts = vim.tbl_deep_extend("force", server:get_default_options(), opts)
      require("config.lsp.rust").setup(opts)
    end
    lspconfig[server_name].setup(opts)
  end
  vim.cmd [[ do User LspAttachBuffers ]]
  -- lspi.on_server_ready(function(server)
  -- end)
end

return M
