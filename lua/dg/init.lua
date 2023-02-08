local win, buf
local M = {}

dg_vault_path = ""
dg_opts = {
    fext = ".md"
}


M.hello = function()
    print("hello from dragonglass")
end

M.start = function()
    local curr_buf_ext = string.sub(vim.api.nvim_buf_get_name(0), -3)
    if curr_buf_ext == dg_opts.fext then
        M.open_window()
    else
        print("dragonglass.nvim: not a markdown file")
    end
end

M.set_path = function(opts)
    print("Options: ", opts)
    dg_vault_path = opts.path
    print("path set to: ", dg_vault_path)
end

M.open_window = function()
    local curr_buf_ext = string.sub(vim.api.nvim_buf_get_name(0), -3)
    if not (curr_buf_ext == dg_opts.fext) 
    then
        return
    end

    local win_width = vim.o.columns
    local win_height = vim.o.lines

    local win_opts = {
        style = "minimal",
        relative = "win",
        width = win_width,
        height = win_height,
        col = win_width,
        row = win_height,
    }

    buf = vim.api.nvim_create_buf(false, true)
    win = vim.api.nvim_open_win(buf, true, win_opts)

    vim.api.nvim_win_set_option(win, "winblend", 0)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "filetype", "glowpreview")

    local keymap_opts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set("n", "i", M.close_window, keymap_opts)


end

M.close_window = function()
    vim.api.nvim_win_close(win, true)
    vim.cmd(":startinsert")
end

M.render = function()
    local curr_file = vim.fn.expand('%')
    local args = { fargs = {curr_file} }

    require('glow').execute(args)
end


return M
