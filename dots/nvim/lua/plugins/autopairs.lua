local npairs = require("nvim-autopairs")
local u = require("utils")

npairs.setup({
    -- check_ts = true,
})

_G.global.on_enter = function()
    if vim.fn.pumvisible() ~= 0 then
        return npairs.esc("<CR>")
    else
        return npairs.autopairs_cr()
    end
end

-- u.map("i", "<CR>", "v:lua.global.on_enter()", { expr = true })
