local theme = {}
local conf = require('modules.themes.config')

theme["projekt0n/github-nvim-theme"] = {
    opt = true,
    config = function()
        -- vim.cmd [[hi CursorLine guibg=#353644]]
        local styles = {"dark", "dark_default", "dimmed"}
        local v = math.random(1, #styles)
        local st = styles[v]
        require("github-theme").setup({
            function_style = "bold",
            theme_style = st,
            sidebars = {"qf", "vista_kind", "terminal", "packer"},
            colors = {bg_statusline = "#332344"}
        })
        -- vim.cmd([[highlight StatusLine guibg='#A3B3C4']])
        vim.cmd([[highlight ColorColumn guibg='#335364']])
        vim.cmd([[doautocmd ColorScheme]])
    end
}

theme["ray-x/aurora"] = {opt = true, config = conf.aurora}

theme["folke/tokyonight.nvim"] = {
    opt = true,
    setup = conf.tokyonight,
    config = function()
        vim.cmd [[hi CursorLine guibg=#353644]]
        vim.cmd([[colorscheme tokyonight]])
        vim.cmd([[hi TSCurrentScope guibg=#282338]])
    end
}

theme["ayu-theme/ayu-vim"] = {
    opt = true,
    config = function()
        vim.cmd("colorscheme ayu")
        vim.cmd([[highlight StatusLine guibg='#A3B3C4']])
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- remove background
        vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE") -- remove background
    end
}

theme["sainnhe/sonokai"] = {opt = true, config = conf.sonokai}

theme["rebelot/kanagawa.nvim"] = {opt = true, config = conf.kangawa}

theme["sainnhe/gruvbox-material"] = {opt = true, config = conf.gruvbox}

theme["altercation/vim-colors-solarized"] = {opt = true}

theme["lambdalisue/glyph-palette.vim"] = {}

theme["xiyaowong/nvim-transparent"] = {
    opt = true,
    config = function()
        require("transparent").setup({
            enable = true, -- boolean: enable transparent
            extra_groups = {}, -- table/string: additional groups that should be clear
            -- In particular, when you set it to 'all', that means all avaliable groups
            exclude = {
                -- "IndentBlanklineIndent1",
                -- "IndentBlanklineIndent2",
                -- "IndentBlanklineIndent3",
                -- "IndentBlanklineIndent4",
                -- "IndentBlanklineIndent5",
                -- "IndentBlanklineIndent6",
                "Tabline",
                "TablineSel",
                "TablineFill",
            } -- table: groups you don't want to clear
        })
    end
}

theme["mcchrish/zenbones.nvim"] = {}

theme["cocopon/iceberg.vim"] = {}

theme["EdenEast/nightfox.nvim"] = {
    opt = true,
    config = function()
      vim.cmd("colorscheme nightfox")
      vim.cmd("doautocmd ColorScheme")
    end
}

return theme
