-- https://github.com/nanotee/nvim-lua-guide
-- https://github.com/nvim-lua/kickstart.nvim

print("Hello Laracasts!")

require('user/plugins')
require('user/options')
require('user/keymaps')


-- vim.api.nvim_create_autocmd({"bufwrite"}, {
--         callback = fn
--     } )

-- local api = vim.api
-- local buf, win

--  function open_window()
--     buf = api.nvim_create_buf(false, true)
--     api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

--     local width = api.nvim_get_option("columns")
--     local height = api.nvim_get_option("lines")

--     local win_height = math.ceil(height * 0.8 -4)
--     local win_width = math.ceil(width + 0.8)

--     local row = math.ceil((height- win_height)/2 -1)
--     local col = math.ceil((width- win_width)/2)

--     local opts = {
--         style = "minimal",
--         relative = "editor",
--         width = win_width,
--         height = win_height,
--         row = row,
--         col = col,
--     }

--     win = api.nvim_open_win(buf, true, opts)
-- end

-- function update_view() 
--   result = vim.fn.systemlist('git diff-tree --no-commit-id --name-only -r HEAD')

--   for k,v in pairs(result) do
--     result[k] = ' '..result[k]    
--   end

--   api.nvim_buf_set_lines(buf, 0, -1, false, result)

-- end
