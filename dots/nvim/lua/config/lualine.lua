vim.cmd("au User LspProgressUpdate let &ro = &ro")

local config = {
  options = {
    theme = "catppuccin",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", path = 1, symbols = { modified = "  ", readonly = "" } },
      -- {
      -- 	function()
      -- 		local gps = require("nvim-gps")
      -- 		return gps.get_location()
      -- 	end,
      -- 	cond = function()
      -- 		local gps = require("nvim-gps")
      -- 		return pcall(require, "nvim-treesitter.parsers") and gps.is_available()
      -- 	end,
      -- 	color = { fg = "#ff9e64" },
      -- },
    },
    -- lualine_x = { lsp_progress },
    lualine_y = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" },
}

-- try to load matching lualine theme

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then config.options.theme = name end
  require("lualine").setup(config)
end

M.load()

-- vim.api.nvim_exec([[
--   autocmd ColorScheme * lua require("config.lualine").load();
-- ]], false)

return M
