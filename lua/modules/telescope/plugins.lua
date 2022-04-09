local telescope = {}
local conf = require('modules.telescope.config')

telescope["tami5/sqlite.lua"] = {}

telescope["nvim-telescope/telescope.nvim"] = {
  cmd = "Telescope",
  config = conf.telescope,
  setup = conf.telescope_preload,
  requires = {
    { "nvim-lua/plenary.nvim", opt = true },
    { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
    { "nvim-telescope/telescope-live-grep-raw.nvim", opt = true },
    { "nvim-telescope/telescope-file-browser.nvim", opt = true },
  },
  opt = true,
}

telescope["ahmedkhalf/project.nvim"] = {
    opt = true,
    after = {"telescope.nvim"},
    keys = {'<M>'},
    config = conf.project
}

telescope["jvgrootveld/telescope-zoxide"] = {
    opt = true,
    keys = {'<M>'},
    after = {"telescope.nvim"},
    config = function()
        require 'modules.telescope.telescope'
        require('telescope').load_extension('zoxide')
    end
}


telescope["AckslD/nvim-neoclip.lua"] = {
  opt = true,
  keys = { "<M>" },
  after = { "telescope.nvim" },
  requires = { "tami5/sqlite.lua", module = "sqlite" },
  config = function()
    require("modules.telescope.telescope")
    require("neoclip").setup({ db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3" })
  end,
}

telescope["nvim-telescope/telescope-frecency.nvim"] = {
  keys = { "<M>" },
  after = { "telescope.nvim" },
  requires = { "tami5/sqlite.lua", module = "sqlite", opt = true },
  opt = true,
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("frecency")
    telescope.setup({
      extensions = {
        frecency = {
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = { "*.git/*", "*/tmp/*" },
          disable_devicons = false,
          workspaces = {
            -- ["conf"] = "/home/my_username/.config",
            -- ["data"] = "/home/my_username/.local/share",
            -- ["project"] = "/home/my_username/projects",
            -- ["wiki"] = "/home/my_username/wiki"
          },
        },
      },
    })
    -- vim.api.nvim_set_keymap("n", "<leader><leader>p", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
  end,
}telescope["rmagatti/session-lens"] = {
    cmd = "SearchSession",
    after = {'telescope.nvim'},
    config = function()
        require"packer".loader("telescope.nvim")
        require("telescope").load_extension("session-lens")
        require('session-lens').setup {
            path_display = {'shorten'},
            theme_conf = {border = true},
            previewer = true
        }
    end
}

telescope["ThePrimeagen/git-worktree.nvim"] = {
    event = {"CmdwinEnter", "CmdlineEnter"},
    config = conf.worktree
}

return telescope
