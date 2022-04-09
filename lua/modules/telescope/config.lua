local config = {}

function config.telescope_preload()
    if not packer_plugins["plenary.nvim"].loaded then
        require"packer".loader("plenary.nvim")
    end
    -- if not packer_plugins["telescope-fzy-native.nvim"].loaded then
    --   require"packer".loader("telescope-fzy-native.nvim")
    -- end
end

function config.telescope() require("modules.telescope.telescope").setup() end

function config.project()
    require("project_nvim").setup {
        datapath = vim.fn.stdpath("data"),
        ignore_lsp = {'efm'},
        exclude_dirs = {"~/.cargo/*"},
        silent_chdir = false
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
    require 'modules.telescope.telescope'
    require('telescope').load_extension('projects')

end

function config.worktree()
    function git_worktree(arg)
        if arg == "create" then
            require("telescope").extensions.git_worktree.create_git_worktree()
        else
            require("telescope").extensions.git_worktree.git_worktrees()
        end
    end

    require("git-worktree").setup({})
    vim.api.nvim_add_user_command("Worktree", 'lua git_worktree(<f-args>)', {
        nargs = "*",
        complete = function() return {"create"} end
    })

    local Worktree = require("git-worktree")
    Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
            print("Switched from " .. metadata.prev_path .. " to " ..
                      metadata.path)
        end

        if op == Worktree.Operations.Create then
            print("Create worktree " .. metadata.path)
        end

        if op == Worktree.Operations.Delete then
            print("Delete worktree " .. metadata.path)
        end
    end)
end

return config
