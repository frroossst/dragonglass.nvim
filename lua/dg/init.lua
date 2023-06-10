local win, buf
local M = {}


-- test function
M.hello = function()
    print('Hello World')
end

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
-- [test link](~/todo.list)
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

M.showHTML = function()
    print('called html()')
    local html_file = io.open('./test_cases/output.html', 'r')
    local html = html_file:read('*all')
    html_file:close()

    vim.cmd('silent! new')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(html, '\n'))
    vim.bo.filetype = 'vue'
    vim.cmd('normal! gg')
end


return M
