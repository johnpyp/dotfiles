local SHOULD_INSTALL_ALL = true

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {},
      -- Disabled in favor of yati + tmindent
      indent = { enable = false },
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      -- Override other options and set it to "all"
      if type(opts.ensure_installed) == "table" and SHOULD_INSTALL_ALL then
        opts.ensure_installed = "all"
      else
        opts.ensure_installed = require("oko.utils").dedup(opts.ensure_installed)
      end
      --   opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          endwise = { enable = true },
        },
      },
    },
  },
}
