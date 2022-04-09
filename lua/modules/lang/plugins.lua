local lang = {}
local conf = require("modules.lang.config")

lang["nathom/filetype.nvim"] = {
    -- event = {'BufEnter'},
    setup = function() vim.g.did_load_filetypes = 1 end
}

lang["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    config = conf.nvim_treesitter,
    require = {
        'tree-sitter/tree-sitter-cpp',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-neorg/tree-sitter-norg', 'David-Kunz/treesitter-unit',
        'windwp/nvim-ts-autotag', 'p00f/nvim-ts-rainbow',
        'MDeiml/tree-sitter-markdown'

        -- 'nvim-treesitter/nvim-treesitter-refactor',
        -- 'JoosepAlviste/nvim-ts-context-commentstring', 'windwp/nvim-ts-autotag',
        -- 'p00f/nvim-ts-rainbow'
    }
}

lang["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
    config = conf.treesitter_obj,
    opt = true
}

lang["RRethy/nvim-treesitter-textsubjects"] = {
    opt = true,
    config = conf.tsubject
}

-- lang["danymat/neogen"] = {
--   opt = true,
--   config = function()
--     require("neogen").setup()
--   end,
-- }

lang["ThePrimeagen/refactoring.nvim"] = {opt = true, config = conf.refactor}

lang["nvim-treesitter/nvim-treesitter-refactor"] = {
    after = "nvim-treesitter-textobjects", -- manual loading
    config = conf.treesitter_ref, -- let the last loaded config treesitter
    opt = true
}

lang["nvim-treesitter/playground"] = {
    -- after = "nvim-treesitter",
    opt = true,
    cmd = "TSPlaygroundToggle",
    config = conf.playground
}

lang["yardnsm/vim-import-cost"] = {cmd = "ImportCost", opt = true}

-- lang['scalameta/nvim-metals'] = {requires = {"nvim-lua/plenary.nvim"}}
-- lang["lifepillar/pgsql.vim"] = {ft = {"sql", "pgsql"}}

lang["nanotee/sqls.nvim"] = {
    ft = {"sql", "pgsql"},
    setup = conf.sqls,
    opt = true
}

lang["ray-x/navigator.lua"] = {
    requires = {"ray-x/guihua.lua", run = "cd lua/fzy && make"},
    config = conf.navigator,
    opt = true
}

-- lang["ray-x/web-tools.nvim"] = {
--     ft = {"html", "javascript"},
--     opt = true,
--     config = function() require('web-tools').setup() end
-- }

-- lang["gcmt/wildfire.vim"] = {
--     setup = function()
--     end,
--     keys = {"<CR>", "<BS>"},
--     fn = {
--         '<Plug>(wildfire-fuel)', '<Plug>(wildfire-water)',
--         '<Plug>(wildfire-quick-select)'
--     }
-- }

-- great plugin but not been maintained
-- lang["ElPiloto/sidekick.nvim"] = {opt = true, fn = {'SideKickNoReload'}, setup = conf.sidekick}

lang["simrat39/symbols-outline.nvim"] = {
    opt = true,
    cmd = {"SymbolsOutline", "SymbolsOutlineOpen"},
    setup = conf.outline
}

lang["mfussenegger/nvim-dap"] = {config = conf.dap, opt = true} -- cmd = "Luadev",

lang["JoosepAlviste/nvim-ts-context-commentstring"] = {opt = true}

lang["rcarriga/nvim-dap-ui"] = {
    -- requires = {"mfussenegger/nvim-dap"},
    config = conf.dapui,
    cmd = "Luadev",
    opt = true
}

lang["theHamsta/nvim-dap-virtual-text"] = {opt = true, cmd = "Luadev"}

lang["nvim-telescope/telescope-dap.nvim"] = {
    config = conf.dap,
    -- cmd = "Telescope",
    opt = true
}

lang["mfussenegger/nvim-dap-python"] = {ft = {"python"}}

lang["mtdl9/vim-log-highlighting"] = {ft = {"text", "log"}}

 lang["michaelb/sniprun"] = {
   run = "bash install.sh",
   opt = true,
   cmd = {"SnipRun", "SnipReset"},
      config = function() require'sniprun'.setup({
      selected_interpreters = {},     --" use those instead of the default for the current filetype
      repl_enable = {},               --" enable REPL-like behavior for the given interpreters
      repl_disable = {},              --" disable REPL-like behavior for the given interpreters

      inline_messages = 1             --" inline_message (0/1) is a one-line way to display messages
    })
    end
 }
-- JqxList and JqxQuery json browsing, format
-- lang["gennaro-tedesco/nvim-jqx"] = {opt = true, cmd = {"JqxList", "JqxQuery"}}

lang["windwp/nvim-ts-autotag"] = {
    opt = true
    -- after = "nvim-treesitter",
    -- config = function() require"nvim-treesitter.configs".setup {autotag = {enable = true}} end
}

lang["p00f/nvim-ts-rainbow"] = {
    opt = true,
    -- after = "nvim-treesitter",
    -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    -- cmd = "Rainbow",
    config = function()
        require("nvim-treesitter.configs").setup({
            rainbow = {enable = true, extended_mode = true}
        })
    end
}

lang["folke/trouble.nvim"] = {
    cmd = {"Trouble", "TroubleToggle"},
    config = function() require("trouble").setup({}) end
}
return lang
