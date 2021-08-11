local u = require("utils")

local api = vim.api

local for_each_buffer = function(cb, force)
    u.for_each(vim.fn.getbufinfo({ buflisted = true }), function(b)
        if b.changed == 0 and not force then
            cb(b)
        end
    end)
end

local commands = {}

commands.bonly = function(bufnr)
    bufnr = bufnr or api.nvim_get_current_buf()
    for_each_buffer(function(b)
        if b.bufnr ~= bufnr then
            vim.cmd("silent! bdelete " .. b.bufnr)
        end
    end)
end

u.lua_command("Bonly", "global.commands.bonly()")

commands.bwipeall = function()
    for_each_buffer(function(b)
        vim.cmd("silent! bdelete " .. b.bufnr)
    end)
end

u.lua_command("Bwipeall", "global.commands.bwipeall()")

commands.wwipeall = function()
    local win = api.nvim_get_current_win()
    u.for_each(vim.fn.getwininfo(), function(w)
        if w.winid ~= win then
            if w.loclist == 1 then
                vim.cmd("lclose")
            elseif w.quickfix == 1 then
                vim.cmd("cclose")
            else
                vim.cmd(w.winnr .. " close")
            end
        end
    end)
end

u.lua_command("Wwipeall", "global.commands.wwipeall()")

commands.bdelete = function(bufnr)
    local win = api.nvim_get_current_win()
    bufnr = bufnr or api.nvim_win_get_buf(win)

    local target
    local previous = vim.fn.bufnr("#")
    if previous ~= -1 and previous ~= bufnr and vim.fn.buflisted(previous) == 1 then
        target = previous
    end

    if not target then
        for_each_buffer(function(b)
            if not target and b.bufnr ~= bufnr then
                target = b.bufnr
            end
        end)
    end

    if not target then
        target = api.nvim_create_buf(false, false)
    end

    local windows = vim.fn.getbufinfo(bufnr)[1].windows
    u.for_each(windows, function(w)
        api.nvim_win_set_buf(w, target)
    end)

    vim.cmd("silent! bdelete " .. bufnr)
end

u.lua_command("Bdelete", "global.commands.bdelete()")
u.map("n", "<Leader>q", ":Bdelete<CR>")

_G.global.commands = commands

return commands
