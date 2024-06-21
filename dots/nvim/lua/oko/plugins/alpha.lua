---@type LazySpec
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function(_, opts)
    local alpha = require("alpha")
    local startify = require("alpha.themes.startify")

    startify.section.header.val = {
      [[ ________      ___  __        ________     ]],
      [[|\   __  \    |\  \|\  \     |\   __  \    ]],
      [[\ \  \|\  \   \ \  \/  /|_   \ \  \|\  \   ]],
      [[ \ \  \\\  \   \ \   ___  \   \ \  \\\  \  ]],
      [[  \ \  \\\  \   \ \  \\ \  \   \ \  \\\  \ ]],
      [[   \ \_______\   \ \__\\ \__\   \ \_______\]],
      [[    \|_______|    \|__| \|__|    \|_______|]],
      [[                                           ]],
      [[                                           ]],
      [[                                           ]],
    }

    alpha.setup(startify.config)
  end,
  -- config = function() require("alpha").setup(require("alpha.themes.startify").config) end,
}
