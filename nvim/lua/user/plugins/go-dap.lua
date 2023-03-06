local dap = require('dap')
require('dapui').setup()
require('nvim-dap-virtual-text').setup()

dap.adapters.go = function(callback, _)
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
    assert(handle, "error running dlv: " .. tostring(pid_or_err))
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
        name = "debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "go",
        name = "debug test",
        request = "launch",
        mode = "test",
        program = "${file}",
    },
    {
        type = "go",
        name = "debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativefiledirname}",
    },
}


------------------ 

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/artem/notes/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}


