local function daylight()
    local h = tonumber(os.date("%H"))
    if h > 6 and h < 18 then
        return "light"
    else
        return "dark"
    end
end

local loader = require("packer").loader
_G.PLoader = loader
function Lazyload()
    --
    math.randomseed(os.time())
    local themes = {
        -- "starry.nvim",
        -- "aurora",
        -- "tokyonight.nvim"
        -- "vim-colors-solarized"
        -- "starry.nvim",
        -- "aurora",
        -- "gruvbox",
        -- "ayu-vim"
        -- "gruvbox-material",
        "nightfox.nvim"
        -- "sonokai"
        -- "github-nvim-theme",
    }

    -- if daylight() == "light" then themes = {"ayu-vim"} end

    local v = math.random(1, #themes)
    local loading_theme = themes[v]

    loader(loading_theme)
    --
    if vim.wo.diff then
        -- loader(plugins)
        print("diffmode")
        vim.cmd([[packadd nvim-treesitter]])
        require("nvim-treesitter.configs").setup({
            highlight = {enable = true, use_languagetree = false}
        })
        vim.cmd([[syntax on]])
        return
    end

    print("I am lazy")

    local disable_ft = {
        "NvimTree", "guihua", "guihua_rust", "TelescopePrompt", "csv", "txt",
        "defx", "sidekick"
    }

    local syn_on = not vim.tbl_contains(disable_ft, vim.bo.filetype)
    if syn_on then
        vim.cmd([[syntax on]])
    else
        vim.cmd([[syntax manual]])
    end

    -- local fname = vim.fn.expand("%:p:f")
    local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
    if fsize == nil or fsize < 0 then fsize = 1 end

    local load_lsp = true
    local load_ts_plugins = true

    if fsize > 1024 * 1024 then
        load_ts_plugins = false
        load_lsp = false
    end
    if fsize > 6 * 1024 * 1024 then
        vim.cmd([[syntax off]])
        return
    end

    local plugins = "plenary.nvim" -- nvim-lspconfig navigator.lua   guihua.lua navigator.lua  -- gitsigns.nvim
    loader("plenary.nvim")

    vim.g.vimsyn_embed = "lPr"

    local gitrepo = vim.fn.isdirectory(".git/index")
    if gitrepo then
        loader("gitsigns.nvim") -- neogit vgit.nvim
    end
    --
    print(load_lsp)
    if load_lsp then
        loader("cmp-nvim-lsp")
        loader("popfix")
        loader("nvim-lsp-ts-utils")
        loader("nvim-lspconfig") -- null-ls.nvim
        loader("lsp_signature.nvim")
        -- loader("lspkind-nvim")
        loader("nvim-lsputils")
        loader("nvim-lsp-installer")
        print("Loaded lsp")
    end

    require("vscripts.cursorhold")
    require("vscripts.tools")

    if load_ts_plugins then
        -- print('load ts plugins')
        loader("nvim-treesitter")
    end

    if load_lsp or load_ts_plugins then
        loader("guihua.lua")
        loader("navigator.lua")
    end

    -- local bytes = vim.fn.wordcount()['bytes']
    if load_ts_plugins then
        plugins =
            "nvim-treesitter-textobjects nvim-ts-autotag nvim-ts-context-commentstring nvim-treesitter-textsubjects"--  nvim-ts-rainbow  nvim-treesitter nvim-treesitter-refactor

        -- nvim-treesitter-textobjects should be autoloaded
        loader("refactoring.nvim")
        loader("indent-blankline.nvim")
    end

    -- loader("nvim-notify")
    -- if bytes < 2 * 1024 * 1024 and syn_on then
    --   vim.cmd([[setlocal syntax=on]])
    -- end

    vim.cmd([[autocmd FileType vista,guihua setlocal syntax=on]])
    vim.cmd(
        [[autocmd FileType * silent! lua if vim.fn.wordcount()['bytes'] > 2048000 then print("syntax off") vim.cmd("setlocal syntax=off") else print('setlocal syntax=on') vim.cmd("setlocal syntax=on") end]])
    -- local cmd = [[au VimEnter * ++once lua require("packer.load")({']] .. loading_theme
    --                 .. [['}, { event = "VimEnter *" }, _G.packer_plugins)]]
    -- vim.cmd(cmd)
    -- loader('windline.nvim')
    -- require("modules.ui.eviline")
    -- require('wlfloatline').setup()
end

vim.cmd([[autocmd User LoadLazyPlugin lua Lazyload()]])
vim.cmd("command! Gram lua require'modules.tools.config'.grammcheck()")
vim.cmd("command! Spell call spelunker#check()")

local lazy_timer = 50
if _G.packer_plugins == nil or _G.packer_plugins["packer.nvim"] == nil then
    print("recompile")
    vim.cmd([[PackerCompile]])
    vim.defer_fn(function()
        print("Packer recompiled, please run `:PackerCompile` and restart nvim")
    end, 1000)
    return
end

vim.defer_fn(function() vim.cmd([[doautocmd User LoadLazyPlugin]]) end,
             lazy_timer)

vim.defer_fn(function()
    -- lazyload()
    local cmd = "TSEnableAll highlight " .. vim.o.ft
    vim.cmd(cmd)
    vim.cmd(
        [[autocmd BufEnter * silent! lua vim.fn.wordcount()['bytes'] < 2048000 then vim.cmd('set syntax=on') local cmd= "TSBufEnable "..vim.o.ft vim.cmd(cmd) print(cmd, vim.o.ft, vim.o.syntax) end]])
    -- vim.cmd([[doautocmd ColorScheme]])
    -- vim.cmd(cmd)
end, lazy_timer + 20)

vim.cmd([[hi LineNr guifg=#505068]])

vim.defer_fn(function()
    --  defer in time
    local loader = require("packer").loader
    loader("sqlite.lua")
    loader("telescope-frecency.nvim")
    loader("telescope.nvim telescope-zoxide project.nvim nvim-neoclip.lua")
    -- loader("neogen")
    loader("harpoon")
    loader("tabby.nvim")
    -- loader("nvim-transparent")
    -- vim.cmd [[TransparentEnable]]
    loader("windline.nvim")
    require("modules.ui.eviline")
    -- require("wlfloatline").setup()
end, lazy_timer + 100)
