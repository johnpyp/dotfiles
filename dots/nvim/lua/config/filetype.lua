require("filetype").setup({
  overrides = {
    extensions = {
      fish = "fish",
      wgsl = "wgsl",
      sql = "sql",
      sh = "bash",
    },
    literal = {
      [".eslintrc"] = "jsonc",
      ["yarn.lock"] = "",
      ["justfile"] = "just",
    },
    complex = {
      [".*/tsconfig.*%.json"] = "jsonc",
    },
  },
})
