require("filetype").setup({
  overrides = {
    extensions = {
      fish = "fish",
      wgsl = "wgsl",
    },
    literal = {
      [".eslintrc"] = "jsonc",
      ["yarn.lock"] = "",
    },
    complex = {
      [".*/tsconfig.*%.json"] = "jsonc",
    },
  },
})
