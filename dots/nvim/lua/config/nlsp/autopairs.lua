local cmp = require("cmp")

local M = {}

function M.setup_autopairs()
  require("nvim-autopairs").setup()

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
