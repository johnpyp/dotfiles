---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = "all",
      -- Disabled in favor of yati + tmindent
      indent = { enable = false },
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      -- if type(opts.ensure_installed) == "table" then
      --   opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      -- end
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
