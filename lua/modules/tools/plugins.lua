local tools = {}
local conf = require('modules.tools.config')

tools["numToStr/Navigator.nvim"] = {
    config = function() require('Navigator').setup() end
}

-- tools["zeertzjq/which-key.nvim"] = {branch = "patch-1"}
tools["folke/which-key.nvim"] = {}

tools["kristijanhusak/vim-dadbod-ui"] = {
    cmd = {
        "DBUIToggle", "DBUIAddConnection", "DBUI", "DBUIFindBuffer",
        "DBUIRenameBuffer", "DB"
    },
    config = conf.vim_dadbod_ui,
    requires = {"tpope/vim-dadbod", ft = {'sql'}},
    opt = true,
    setup = function()
        vim.g.dbs = {
            eraser = 'postgres://postgres:password@localhost:5432/eraser_local',
            staging = 'postgres://postgres:password@localhost:5432/my-staging-db',
            wp = 'mysql://root@localhost/wp_awesome'
        }
    end
}

tools['vim-test/vim-test'] = {cmd = {'TestNearest', 'TestFile', 'TestSuite'}}

tools["editorconfig/editorconfig-vim"] = {
    opt = true,
    cmd = {"EditorConfigReload"}
    -- ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

tools['ThePrimeagen/harpoon'] = {
    opt = true,
    config = function()
        require("harpoon").setup({
            global_settings = {
                save_on_toggle = false,
                save_on_change = true,
                enter_on_sendcmd = false,
                tmux_autoclose_windows = false,
                excluded_filetypes = {"harpoon"}
            }
        })
    end
}

-- github GH ui
-- tools['pwntester/octo.nvim'] ={
--   cmd = {'Octo', 'Octo pr list'},
--   config=function()
--     require"octo".setup()
--   end
-- }

-- tools["wellle/targets.vim"] = {}

tools["TimUntersberger/neogit"] = {cmd = {"Neogit"}, config = conf.neogit}

tools["liuchengxu/vista.vim"] = {
    cmd = "Vista",
    setup = conf.vim_vista,
    opt = true
}

tools["kamykn/spelunker.vim"] = {
    opt = true,
    fn = {"spelunker#check"},
    setup = conf.spelunker,
    config = conf.spellcheck
}
tools["rhysd/vim-grammarous"] = {
    opt = true,
    cmd = {"GrammarousCheck"},
    ft = {"markdown", "txt"},
    setup = conf.grammarous
}

tools["plasticboy/vim-markdown"] = {
    ft = "markdown",
    requires = {"godlygeek/tabular"},
    cmd = {"Toc"},
    setup = conf.markdown,
    opt = true
}

tools["iamcco/markdown-preview.nvim"] = {
    ft = {"markdown", "pandoc.markdown", "rmd"},
    cmd = {"MarkdownPreview"},
    setup = conf.mkdp,
    run = [[sh -c "cd app && yarn install"]],
    opt = true
}

--     browser-sync https://github.com/BrowserSync/browser-sync
tools["turbio/bracey.vim"] = {
    ft = {"html", "javascript", "typescript"},
    cmd = {"Bracey", "BraceyEval"},
    run = 'sh -c "npm install --prefix server"',
    opt = true
}

-- nvim-toggleterm.lua ?
tools["voldikss/vim-floaterm"] = {
    cmd = {"FloatermNew", "FloatermToggle"},
    setup = conf.floaterm,
    opt = true
}

tools["akinsho/toggleterm.nvim"] = {
    opt = true,
    cmd = {"ToggleTerm"},
    confit = conf.toggleterm
}
--
tools["nanotee/zoxide.vim"] = {cmd = {"Z", "Lz", "Zi"}, config = function() end}

tools["sindrets/diffview.nvim"] = {
    cmd = {
        "DiffviewOpen", "DiffviewFileHistory", "DiffviewFocusFiles",
        "DiffviewToggleFiles", "DiffviewRefresh"
    },
    config = conf.diffview
}

tools["lewis6991/gitsigns.nvim"] = {
    config = conf.gitsigns,
    -- keys = {']c', '[c'},  -- load by lazy.lua
    opt = true
}

tools["ray-x/sad.nvim"] = {
    cmd = {'Sad'},
    opt = true,
    config = function()
        require'sad'.setup({debug = true, log_path = "~/tmp/neovim_debug.log"})
    end
}

tools["ray-x/viewdoc.nvim"] = {
    cmd = {'Viewdoc'},
    opt = true,
    config = function()
        require'viewdoc'.setup({
            debug = true,
            log_path = "~/tmp/neovim_debug.log"
        })
    end
}

-- early stage...
-- tools['tanvirtin/vgit.nvim'] = { -- gitsign has similar features
--     setup = function() vim.o.updatetime = 2000 end,
--     cmd = {'VGit'},
--     -- after = {"telescope.nvim"},
--     opt = true,
--     config = conf.vgit
-- }

tools["tpope/vim-fugitive"] = {
    cmd = {
        "Gvsplit", "Git", "Gedit", "Gstatus", "Gdiffsplit", "Gvdiffsplit", "G"
    },
    opt = true
}

tools["rmagatti/auto-session"] = {config = conf.session}

tools['kevinhwang91/nvim-bqf'] = {
    opt = true,
    event = {"CmdlineEnter", "QuickfixCmdPre"},
    config = conf.bqf
}

-- tools["romainl/vim-qf"] = {}

tools["rcarriga/vim-ultest"] = {
    requires = {"vim-test/vim-test", setup = conf.vim_test, opt = true},
    cmd = {"Ultest", "UltestNearest"},
    run = function()
        vim.cmd [[packadd vim-ultest]]
        vim.cmd [[UpdateRemotePlugins]]
    end,
    config = function() vim.cmd [[UpdateRemotePlugins]] end,
    opt = true
}

tools["sQVe/sort.nvim"] = {
    opt = true,
    cmd = {"Sort"},
    config = function()
        require("sort").setup({
            delimiters = {
                ',', '|', ';', ':', 's', -- Space
                't' -- Tab
            }
        })
    end
}

tools["tpope/vim-repeat"] = {}

tools["rhysd/git-messenger.vim"] = {opt = true, cmd = {"GitMessenger"}}

tools["monaqa/dial.nvim"] = {
    opt = true,
    cmd = {
        "<Plug>>(dial-increment-additional)",
        "<Plug>>(dial-decrement-additional)"
    },
    keys = {"<C-a>", "<C-x>"},
    config = function()
        local dial = require("dial")
        dial.config.searchlist.normal = {
            "number#decimal", "number#hex", "number#binary", "date#[%Y/%m/%d]",
            "markup#markdown#header", 'date#[%Y-%m-%d]', 'date#[%H:%M:%S]',
            'date#[%H:%M]'
        }
        -- toggle ture/false
        dial.augends["custom#boolean"] =
            dial.common.enum_cyclic {
                name = "boolean",
                strlist = {"true", "false"}
            }

        table.insert(dial.config.searchlist.normal, "custom#boolean")
    vim.cmd[[nmap <C-a> <Plug>(dial-increment)]]
    vim.cmd[[nmap <C-x> <Plug>(dial-decrement)]]
    vim.cmd[[vmap <C-a> <Plug>(dial-increment)]]
    vim.cmd[[vmap <C-x> <Plug>(dial-decrement)]]
    vim.cmd[[vmap g<C-a> <Plug>(dial-increment-additional)]]
    vim.cmd[[vmap g<C-x> <Plug>(dial-decrement-additional)]]
    end
}

tools["lambdalisue/suda.vim"] = {
    opt = true,
    config = function() vim.g.suda_smart_edit = 1 end
}

tools["tpope/vim-dispatch"] = {}

tools["folke/todo-comments.nvim"] = {
  requires = {"nvim-lua/plenary.nvim"},
  config = function()
    require("todo-comments").setup {
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
  },
    }
  end
}
return tools
