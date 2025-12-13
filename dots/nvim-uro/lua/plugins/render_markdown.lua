---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      -- Show backticks normally
      conceal_delimiters = false,
      -- Show backticks normally (fixes top backticks rendering)
      language = false,
      -- Show backticks normally (fixes bottom backticks rendering)
      border = "none",
    },
  },
}
