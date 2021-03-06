local Path = require('plenary.path')
require('cmake').setup({
    parameters_file = 'neovim.json', -- JSON file to store information about selected target, run arguments and build type.
    build_dir = tostring(Path:new('{cwd}', 'build', '{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values.
    -- samples_path = tostring(script_path:parent():parent():parent() / 'samples'), -- Folder with samples. `samples` folder from the plugin directory is used by default.
    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'Projects')), -- Default folder for creating project.
    configure_args = {'-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1'}, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
    build_args = {}, -- Default arguments that will be always passed at cmake build step.
    quickfix_height = 30, -- Height of the opened quickfix.
    dap_configuration = {type = 'cpp', request = 'launch'}, -- DAP configuration. By default configured to work with `lldb-vscode`.
    dap_open_command = require('dap').repl.open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
    type = 'codelldb',
    request = 'launch',
    stopOnEntry = false,
    runInTerminal = false
})

