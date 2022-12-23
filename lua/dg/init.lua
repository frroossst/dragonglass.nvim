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
    if curr_buf_ext == dg_opts.dg_opts then
        M.win()
    else
        print("not a markdown file")
    end
end

local function set_path(opts)
    print("Options: ", opts)
    dg_vault_path = opts.path
    print("path set to: ", dg_vault_path)
end

local function open_window()
    local win_width = vim.o.columns
    local win_height = vim.o.lines

    local win_opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        --col = win_width,
        --row = win_height,
    }

    buf = vim.api.nvim_create_buf(false, true)
    win = vim.api.nvim_open_win(buf, true, win_opts)

    vim.api.nvim_win_set_option(win, "winblend", 0)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "filetype", "glowpreview")

    local keymap_opts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set("n", "q", close_window, keymap_opts)

end

local function close_window()
    vim.api.nvim_win_close(win, true)
end



return M
