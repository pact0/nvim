local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = {}

ui["dstein64/nvim-scrollview"] = {
    event = {"CursorMoved", "CursorMovedI"},
    config = conf.scrollview
}

ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    config = conf.blankline
}

ui["kyazdani42/nvim-tree.lua"] = {
    cmd = {"NvimTreeToggle", "NvimTreeOpen"},
    -- requires = {'kyazdani42/nvim-web-devicons'},
    setup = conf.nvim_tree_setup,
    config = conf.nvim_tree
}

-- ui["gelguy/wilder.nvim"] = {
--     requires = {
--         {"romgrk/fzy-lua-native"},
--         {'nixprime/cpsm', run = 'UpdateRemotePlugins'}
--     },
--     opt = true,
--     run = "UpdateRemotePlugins",
--     event = {"CmdwinEnter"},
--     config = conf.wilder
-- }

ui["nanozuki/tabby.nvim"] = {opt = true, config = conf.tabby}

-- ui["sidebar-nvim/sidebar.nvim"] = {
--     config = function()
--         require("sidebar-nvim").setup({
--             disable_default_keybindings = 0,
--             bindings = nil,
--             open = true,
--             side = "left",
--             initial_width = 35,
--             hide_statusline = false,
--             update_interval = 1000,
--             sections = {"datetime", "git", "diagnostics"},
--             section_separator = "-----",
--             containers = {
--                 attach_shell = "/bin/sh",
--                 show_all = true,
--                 interval = 5000
--             },
--             datetime = {format = "%a %b %d, %H:%M", clocks = {{name = "local"}}},
--             todos = {ignored_paths = {"~"}},
--             disable_closing_prompt = false
--         })
--     end
-- }

ui["windwp/windline.nvim"] = {
    -- event = "UIEntwindlineer",
    config = conf.windline,
    -- requires = {'kyazdani42/nvim-web-devicons'},
    opt = true
}

return ui
