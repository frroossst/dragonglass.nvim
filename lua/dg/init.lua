local win, buf
local M = {}



-- nnoremap <Esc> :lua M.render()<CR>
-- close window from Glow.nvim setup()
M.render = function()
    local curr_file = vim.fn.expand('%')
    -- check if it is a markdown file
    if string.sub(curr_file, -3) ~= ".md" then
        print('[dragonglass] Not a markdown file')
        return
    end
    local args = { 
        fargs = {curr_file},
        width_ratio =  1.0,
        height_ratio = 1.0,
    }

    require('glow').setup(args)
    vim.cmd(":Glow")
end



-- nnoremap <leader>g :lua M.follow()<CR>
-- follow link under the cursor
M.follow = function()
    local under_cursor = vim.fn.expand('<cword>')
    -- local line_no = vim.fn.line('.')
    -- local curr_line = vim.fn.getline(line_no)
    
    -- get string under the cursor between []() 
    local curr_line = vim.api.nvim_get_current_line()
    local pattern = "%((.-)%)"
    local link = string.match(curr_line, pattern)
    if link == nil then
        print('[dragonglass] No link found')
        return
    end
    print(link)
    vim.api.nvim_command('edit! ' .. link)
end


return M
