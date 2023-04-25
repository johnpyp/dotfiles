require("filetype").setup({
  overrides = {
    extensions = {
      fish = "fish",
      wgsl = "wgsl",
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
