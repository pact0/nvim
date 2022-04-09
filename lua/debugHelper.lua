local dap = require('dap')
-- require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '80vsplit new'
vim.fn.sign_define('DapBreakpoint',
                   {text = '🟥', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapBreakpointRejected',
                   {text = '🟦', texthl = '', linehl = '', numhl = ''})
vim.fn.sign_define('DapStopped',
                   {text = '⭐️', texthl = '', linehl = '', numhl = ''})

local function debugJest(testName, filename)
    print("starting " .. testName .. " in " .. filename)
    dap.run({
        type = 'node2',
        request = 'launch',
        cwd = vim.fn.getcwd(),
        runtimeArgs = {
            '--inspect-brk', '/usr/local/bin/jest', '--no-coverage', '-t',
            testName, '--', filename
        },
        sourceMaps = true,
        protocol = 'inspector',
        skipFiles = {'<node_internals>/**/*.js'},
        console = 'integratedTerminal',
        port = 9229
    })
end

local function attach()
    print("attaching")
    dap.run({
        type = 'node2',
        request = 'attach',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        skipFiles = {'<node_internals>/**/*.js'}
    })
end

local function attachToRemote()
    print("attaching")
    dap.run({
        type = 'node2',
        request = 'attach',
        address = "127.0.0.1",
        port = 9229,
        localRoot = vim.fn.getcwd(),
        remoteRoot = "/home/vcap/app",
        sourceMaps = true,
        protocol = 'inspector',
        skipFiles = {'<node_internals>/**/*.js'}
    })
end

return {debugJest = debugJest, attach = attach, attachToRemote = attachToRemote}
