---@type LazySpec
return {
  -- `mini.misc` contains the rooter func, not a dedicated module
  {
    "echasnovski/mini.misc",
    version = "*",
    init = function(self)
      require("mini.misc").setup_auto_root({ ".git", "_darcs", ".hg", ".bzr", ".svn", ".project", ".projectkeep" })
    end,
  },
}
