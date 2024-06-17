---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  keys = {
    { "<leader>n", "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
  },
  opts = {
    close_if_last_window = true,
    window = {
      auto_expand_width = true,
      position = "right",
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["."] = "toggle_hidden",
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      -- async_directory_scan = "never",
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          --auto close
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
