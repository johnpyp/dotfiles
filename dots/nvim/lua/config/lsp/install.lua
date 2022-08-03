<<<<<<< HEAD
local util = require "util"
=======
local lspconfig = require("lspconfig")
local util = require("util")
>>>>>>> e8bf327 (Installer fixes)

local M = {}

function M.install_missing(servers)
  local lspi_servers = require "nvim-lsp-installer.servers"
  for server, _ in pairs(servers) do
    local ok, s = lspi_servers.get_server(server)
    if ok then
      if not s:is_installed() then s:install() end
    else
      util.error("Server " .. server .. " not found")
    end
  end
end

function M.setup(servers, options)
	M.install_missing(servers)
	for server_name, server_opts in pairs(servers) do
		local opts = vim.tbl_deep_extend("force", options, server_opts or {})

		if server_name == "rust_analyzer" then
			-- opts = vim.tbl_deep_extend("force", server:get_default_options(), opts)
			require("config.lsp.rust").setup(opts)
		end
		lspconfig[server_name].setup(opts)
	end
	vim.cmd([[ do User LspAttachBuffers ]])
	-- lspi.on_server_ready(function(server)
	-- end)
end

return M
