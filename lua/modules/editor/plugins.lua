local editor = {}

local conf = require("modules.editor.config")

-- alternatives: steelsojka/pears.nvim
-- windwp/nvim-ts-autotag  'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue'
-- windwp/nvim-autopairs

-- I like this plugin, but 1) offscreen context is slow
-- 2) it not friendly to lazyload and treesitter startup
editor["andymass/vim-matchup"] = {
    opt = true,
    event = {"CursorMoved", "CursorMovedI"},
    cmd = {'MatchupWhereAmI?'},
    config = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_surround_enabled = 1
        -- vim.g.matchup_transmute_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = {method = 'popup'}
        vim.cmd([[nnoremap <c-s-k> :<c-u>MatchupWhereAmI?<cr>]])
    end
}

-- editor["ggandor/lightspeed.nvim"] = {
--     as = "lightspeed",
--     opt = true,
--     keys = {'f', 'F', 't', 'T', 'S', 's'},
--     config = conf.lightspeed
-- }

editor["tpope/vim-surround"] = {
    opt = true,
    event = "InsertEnter"
    -- keys={'c', 'd'}
}

-- nvim-colorizer replacement
editor["rrethy/vim-hexokinase"] = {
    -- ft = { 'html','css','sass','vim','typescript','typescriptreact'},
    config = conf.hexokinase,
    run = "make hexokinase",
    opt = true,
    cmd = {"HexokinaseTurnOn", "HexokinaseToggle"}
}

-- booperlv/nvim-gomove
-- <A-k>   Move current line/selection up
-- <A-j>   Move current line/selection down
-- <A-h>   Move current character/selection left
-- <A-l>   Move current character/selection right
-- editor["matze/vim-move"] = {
--   opt = true,
--   event = { "CursorMoved", "CursorMovedI" },
--   -- fn = {'<Plug>MoveBlockDown', '<Plug>MoveBlockUp', '<Plug>MoveLineDown', '<Plug>MoveLineUp'}
-- }
editor["kevinhwang91/nvim-hlslens"] = {
    keys = {"/", "?", '*', '#'}, -- 'n', 'N', '*', '#', 'g'
    opt = true,
    config = conf.hlslens
}

editor["mg979/vim-visual-multi"] = {
    keys = {
        "<Ctrl>", "<M>", "<C-n>", "<C-n>", "<M-n>", "<S-Down>", "<S-Up>",
        "<M-Left>", "<M-i>", "<M-Right>", "<M-D>", "<M-Down>", "<C-d>",
        "<C-Down>", "<S-Right>", "<C-LeftMouse>", "<M-LeftMouse>",
        "<M-C-RightMouse>"
    },
    opt = true,
    -- setup = conf.vmulti
    config = function()
        vim.g.VM_default_mappings = 0
        vim.g.VM_mouse_mappings = 1
        vim.cmd([[
        let g:VM_maps = {}
        let g:VM_maps['Find Under'] = '<C-n>'
        let g:VM_maps['Find Subword Under'] = '<C-n>'
        let g:VM_maps['Select All'] = '<C-M-n>'
        let g:VM_maps['Seek Next'] = 'n'
        let g:VM_maps['Seek Prev'] = 'N'
        let g:VM_maps["Undo"] = 'u'
        let g:VM_maps["Redo"] = '<C-r>'
        let g:VM_maps["Remove Region"] = '<cr>'
        let g:VM_maps["Add Cursor Down"] = '<M-Down>'
        let g:VM_maps["Add Cursor Up"] = "<M-Up>"
        let g:VM_maps["Mouse Cursor"] = "<M-LeftMouse>"
        let g:VM_maps["Mouse Word"] = "<M-RightMouse>"
        let g:VM_maps["Add Cursor At Pos"] = '<M-i>'
    ]])
    end
}

editor["indianboy42/hop-extensions"] = {after = "hop", opt = true}

-- EasyMotion in lua. -- maybe replace sneak
editor["phaazon/hop.nvim"] = {
    as = "hop",
    cmd = {
        "HopWord", "HopWordAC", "HopWordBC", "HopLine", "HopChar1",
        "HopChar1AC", "HopChar1BC", "HopChar2", "HopChar2AC", "HopChar2BC",
        "HopPattern", "HopPatternAC", "HopPatternBC", "HopChar1CurrentLineAC",
        "HopChar1CurrentLineBC", "HopChar1CurrentLine"
    },
    config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require("hop").setup({
            keys = "adghklqwertyuiopzxcvbnmfjADHKLWERTYUIOPZXCVBNMFJ1234567890"
        })
        -- vim.api.nvim_set_keymap('n', '$', "<cmd>lua require'hop'.hint_words()<cr>", {})
    end
}

editor["numToStr/Comment.nvim"] = {
    keys = {"g", "<ESC>"},
    event = {"CursorMoved"},
    config = conf.comment,
    requires = {"JoosepAlviste/nvim-ts-context-commentstring"}
}

-- copy paste failed in block mode when clipboard = unnameplus"
editor["bfredl/nvim-miniyank"] = {
    keys = {"p", "y", "<C-v>"},
    opt = true,
    setup = function()
        vim.api.nvim_command("map p <Plug>(miniyank-autoput)")
        vim.api.nvim_command("map P <Plug>(miniyank-autoPut)")
    end
}
editor["dhruvasagar/vim-table-mode"] = {cmd = {"TableModeToggle"}}

-- fix terminal color
editor["norcalli/nvim-terminal.lua"] = {
    opt = true,
    ft = {"log", "terminal"},
    config = function() require("terminal").setup() end
}

editor["simnalamburt/vim-mundo"] = {
    opt = true,
    cmd = {"MundoToggle", "MundoShow", "MundoHide"},
    run = function()
        vim.cmd([[packadd vim-mundo]])
        vim.cmd([[UpdateRemotePlugins]])
    end,
    setup = function()
        -- body
        vim.g.mundo_prefer_python3 = 1
    end
}
editor["mbbill/undotree"] = {opt = true, cmd = {"UndotreeToggle"}}

editor["AndrewRadev/splitjoin.vim"] = {
    opt = true,
    cmd = {"SplitjoinJoin", "SplitjoinSplit"}
}

editor["chaoren/vim-wordmotion"] = {
    -- opt = true,
    -- fn = {"<Plug>WordMotion_w", "<Plug>WordMotion_b"},
    -- keys = {'w','W'},
    config = function()
        vim.g.wordmotion_nomap = 0
        vim.cmd [[nmap w <Plug>WordMotion_w]]
        vim.cmd [[nmap b <Plug>WordMotion_b]]
        vim.cmd [[let g:wordmotion_mappings = {
\ 'ge' : 'g<M-e>',
\ 'aw' : 'a<M-w>',
\ 'iw' : 'i<M-w>',
\ '<C-R><C-W>' : '<C-R><M-w>'
\ }]]
    end
}

editor["folke/zen-mode.nvim"] = {
    opt = true,
    cmd = {"ZenMode"},
    config = function() require("zen-mode").setup({}) end
}

-- editor["nvim-neorg/neorg-telescope"] = {opt = true}
editor["nvim-neorg/neorg"] = {
    opt = true,
    config = conf.neorg,
    ft = "norg",
    after = {"nvim-treesitter"},
    setup = vim.cmd("autocmd BufRead,BufNewFile *.norg setlocal filetype=norg"),
    requires = {"nvim-neorg/neorg-telescope", ft = {"norg"}}
}

editor["machakann/vim-sandwich"] = {opt = true, event = {"CursorMoved"}}

editor["tpope/vim-abolish"] = {opt = true, cmd = {"Subvert", "Abolish"}}

editor["junegunn/vim-easy-align"] = {opt = true, cmd = {"EasyAlign"}}

editor["szw/vim-maximizer"] = {opt = true, cmd = {"MaximizerToggle"}}

-- editor["haya14busa/incsearch.vim"] = {}

editor["vim-scripts/UnconditionalPaste"] = {opt = true}

return editor
