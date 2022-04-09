local map = require("utils").map
local leader = "<space>"

  require("project_nvim").setup {
  -- Manual mode doesn't automatically change your root directory, so you have
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = false,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  detection_methods = { "pattern","lsp"  },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  patterns = { '.git', 'Makefile', '*.sln', 'build/env.sh', "CMakeLists.txt",'composer.json', 'package.json' ,"_darcs", ".hg", ".bzr", ".svn"},

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  ignore_lsp = {"efm"},

  -- Don't calculate root dir on specific directories
  -- Ex: { "~/.cargo/*", ... }
  exclude_dirs = {},

  -- Show hidden files in telescope
  show_hidden = false,

  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  silent_chdir = true,

  -- Path where project.nvim will store the project history for use in
  -- telescope
  datapath = vim.fn.stdpath("data"),
}

require('config-local').setup {
      -- Default configuration (optional)
      config_files = { ".vimrc.lua", ".vimrc" },  -- Config file patterns to load (lua supported)
      hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
      autocommands_create = true,                 -- Create autocommands (VimEnter, DirectoryChanged)
      commands_create = true,                     -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
      silent = false,                             -- Disable plugin messages (Config loaded/ignored)
    }

require('auto-session').setup({
    log_level = 'info',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil
})

vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

