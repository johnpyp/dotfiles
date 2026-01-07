---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    {
      "<leader>n",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Toggle Neo-tree",
    },
  },
  opts = {
    window = {
      position = "right",
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = true,
        always_show = {
          ".github",
          ".gitignore",
        },
        always_show_by_pattern = {
          ".mise*",
          ".env*",
          ".dev.vars*",
          "mise*",
          "*.local.*",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      window = {
        mappings = {
          ["."] = "toggle_hidden",
        },
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
