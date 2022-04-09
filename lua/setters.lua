-- fold settings
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars = "fold: "
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1

-- vim.cmd [[colorscheme gruvbox]]
-- In init.lua or filetype.nvim's config file
require("filetype").setup({
    overrides = {
        extensions = {
            -- Set the filetype of *.pn files to potion
            pn = "potion"
        },
        literal = {
            -- Set the filetype of files named "MyBackupFile" to lua
            MyBackupFile = "lua"
        },
        complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            [".*git/config"] = "gitconfig" -- Included in the plugin
        },

        -- The same as the ones above except the keys map to functions
        function_extensions = {
            ["cpp"] = function()
                vim.bo.filetype = "cpp"
                -- Remove annoying indent jumping
                vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
            end,
            ["pdf"] = function()
                vim.bo.filetype = "pdf"
                -- Open in PDF viewer (Skim.app) automatically
                vim.fn.jobstart("open -a skim " .. '"' .. vim.fn.expand("%") ..
                                    '"')
            end
        },
        function_literal = {Brewfile = function() vim.cmd("syntax off") end},
        function_complex = {
            ["*.math_notes/%w+"] = function() vim.cmd("iabbrev $ $$") end
        },

        shebang = {
            -- Set the filetype of files with a dash shebang to sh
            dash = "sh"
        }
    }
})
-- vim.cmd [[syntax enable]]
-- vim.cmd [[filetype plugin indent on]]
--
-- local opt = setmetatable({}, {
--     __newindex = function(_, key, value)
--         vim.o[key] = value
--         vim.bo[key] = value
--     end,
-- })
--
-- opt.dict = "~/dotfiles/lib/10k.txt"
-- opt.expandtab = true
-- opt.formatoptions = "crqnbj"
-- opt.grepprg = "rg --vimgrep --no-heading --hidden"
-- opt.shiftwidth = 4
-- opt.smartindent = true
-- opt.softtabstop = 4
-- opt.spellcapcheck = ""
-- opt.swapfile = false
-- opt.tabstop = 4
-- opt.textwidth = 80
-- opt.undofile = true
-- opt.undolevels = 10000
--
-- vim.o.clipboard = "unnamedplus"
-- vim.o.completeopt = "menu,menuone,noinsert,noselect"
-- vim.o.confirm = true
-- vim.o.diffopt = "internal,filler,closeoff,foldcolumn:0,hiddenoff"
-- vim.o.emoji = false
-- vim.o.foldclose = "all"
-- vim.o.foldopen = "all"
-- -- vim.opt.foldtext = "v:lua.foldtext()"
-- vim.o.hidden = true
-- vim.o.history = 10000
-- vim.o.ignorecase = true
-- vim.o.inccommand = "nosplit"
-- vim.o.infercase = true
-- vim.o.lazyredraw = true
-- vim.o.mouse = "a"
-- vim.o.pumblend = 10
-- vim.o.ruler = false
-- vim.o.scrolloff = 8
-- vim.o.showbreak = "↳⋅"
-- vim.o.showcmd = false
-- vim.o.showmode = false
-- vim.o.showtabline = 0
-- vim.o.sidescroll = 5
-- vim.o.sidescrolloff = 15
-- vim.o.smartcase = true
-- vim.o.smarttab = true
-- vim.o.splitbelow = true
-- vim.o.splitright = true
-- vim.o.termguicolors = true
-- vim.o.timeoutlen = 500
-- vim.o.undodir = vim.fn.expand "~/.config/nvim/backups"
-- vim.o.updatetime = 0
-- vim.o.viewoptions = ""
-- vim.o.virtualedit = "onemore"
-- vim.o.whichwrap = "b,h,l"
-- vim.o.wildmode = "longest,full"
-- vim.o.wildoptions = "pum"
--
-- vim.wo.foldenable = false
-- vim.wo.foldlevel = 2
-- vim.wo.foldmethod = "indent"
-- vim.wo.colorcolumn = "+1"
-- vim.wo.signcolumn = "yes:1"
-- vim.wo.conceallevel = 2
-- vim.wo.concealcursor = "n"
-- vim.wo.breakindent = true
-- vim.wo.linebreak = true
-- vim.wo.number = true
-- vim.wo.relativenumber = true
-- vim.wo.cursorline = true
-- vim.wo.winhighlight = "NormalNC:WinNormalNC"
-- vim.opt.list = true
-- vim.opt.listchars = {
--     space = "⋅",
--     eol = "↴",
--     tab = "__",
--     trail = "•",
--     extends = "❯",
--     precedes = "❮",
--     nbsp = "_",
-- }
-- vim.opt.fillchars = {
--     fold = " ",
--     diff = "╱",
-- }
--
-- vim.g.floating_window_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
-- vim.g.floating_window_border_dark = {
--     { "╭", "FloatBorderDark" },
--     { "─", "FloatBorderDark" },
--     { "╮", "FloatBorderDark" },
--     { "│", "FloatBorderDark" },
--     { "╯", "FloatBorderDark" },
--     { "─", "FloatBorderDark" },
--     { "╰", "FloatBorderDark" },
--     { "│", "FloatBorderDark" },
-- }
-- vim.g.markdown_fenced_languages = {
--     "vim",
--     "python",
--     "lua",
--     "bash=sh",
--     "javascript",
--     "typescript",
--     "yaml",
--     "json",
--     "gql=graphql",
--     "graphql",
-- }
-- vim.g.no_man_maps = true
-- vim.g.vim_json_syntax_conceal = false
-- vim.g.vim_json_conceal = false
-- vim.g.mapleader = "\\<Space>"
