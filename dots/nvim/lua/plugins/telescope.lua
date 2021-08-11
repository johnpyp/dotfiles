local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local set = require("telescope.actions.set")

local u = require("utils")
local commands = require("commands")

local previewers = require('telescope.previewers')
local themes = require("telescope.themes")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

local function disable_previewer()
  return {
    buffers = {
      previewer = false
    }
  }
end

telescope.setup({
      defaults = {
        -- buffer_previewer_maker = new_maker,
        extensions = {
            fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
        },
        file_ignore_patterns = { "yarn.lock", ".yarn/*"},
        -- generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
        -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case'
        },
        mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
            },
        },
        -- borderchars = {
        --   { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        --   prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
        --   results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
        --   preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        -- },
        -- previewer = false,
        prompt_title = false
    },
})

telescope.load_extension("fzf")

_G.global.telescope = {
    -- try git_files and fall back to find_files
    find_files = function()
        local current = vim.api.nvim_get_current_buf()
        local opts = {
            attach_mappings = function(_, map)
                map("i", "<C-v>", function(prompt_bufnr)
                    set.edit(prompt_bufnr, "Vsplit")
                end)

                -- replace current buffer
                map("i", "<C-r>", function(prompt_bufnr)
                    set.edit(prompt_bufnr, "edit")
                    commands.bdelete(current)
                end)

                -- close all other buffers
                map("i", "<C-o>", function(prompt_bufnr)
                    set.edit(prompt_bufnr, "edit")
                    commands.bonly()
                end)

                -- edit file and matching test file in split
                map("i", "<C-f>", function(prompt_bufnr)
                    set.edit(prompt_bufnr, "edit")
                    commands.edit_test_file("Vsplit", function()
                        vim.cmd("wincmd w")
                    end)
                end)

                return true
            end,
            previewer = false
        }

        local is_git_project = pcall(builtin.git_files, opts)
        if not is_git_project then
            builtin.find_files(opts)
        end
    end,
}

-- u.command("Files", "Telescope find_files")
u.lua_command("Files", "global.telescope.find_files()")
u.command("Lines", "Telescope live_grep previewer=false")
u.command("BLines", "Telescope current_buffer_fuzzy_find")
u.command("History", "Telescope oldfiles")
u.command("Buffers", "Telescope buffers")
u.command("BCommits", "Telescope git_bcommits")
u.command("Commits", "Telescope git_commits")
u.command("HelpTags", "Telescope help_tags")
u.command("ManPages", "Telescope man_pages")

u.map("n", "<Leader>H", ":HelpTags<CR>")

u.map("n", "<C-p>",      "<cmd>Files<CR>")
u.map("n", "<C-i>",      "<cmd>Lines<CR>")

u.map("n", "<Leader>ff", "<cmd>Files<CR>")
u.map("n", "<Leader>fg", "<cmd>Lines<CR>")
u.map("n", "<Leader>fb", "<cmd>Buffers<CR>")
u.map("n", "<Leader>fh", "<cmd>History<CR>")
u.map("n", "<Leader>fl", "<cmd>BLines<CR>")
u.map("n", "<Leader>fs", "<cmd>LspSym<CR>")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")
