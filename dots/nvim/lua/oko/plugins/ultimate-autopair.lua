---Ultimate autopairs
--- "A treesitter supported autopairing plugin with extensions, and much more "
---
---@type LazySpec
return {
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {
      --Config goes here
    },
  },
}
