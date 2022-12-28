local M = {}

function M.setup_mason_ui()
  require("mason.settings").set({
    ui = {
      border = "rounded",
    },
  })
end

return M
