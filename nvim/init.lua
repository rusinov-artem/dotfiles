-- https://github.com/nanotee/nvim-lua-guide
-- https://github.com/nvim-lua/kickstart.nvim

print("Hello Laracasts!")

require('user/plugins')
require('user/options')
require('user/keymaps')

local dap = require('dap')

dap.adapters.go = function(callback, config)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local port = 38697
	local opts = {
		stdio = { nil, stdout },
		args = { "dap", "-l", "127.0.0.1:" .. port },
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print("dlv exited with code", code)
		end
	end)
	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)
end

dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

--require("nvim-dap-virtual-text").setup()
-- require('dap-go').setup()
-- require('dapui').setup()



-- vim.api.nvim_create_autocmd({"BufWrite"}, {
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
