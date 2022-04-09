local config = {}

function config.gruvbox()
    local opt = {"soft", "medium", "hard"}
    local palettes = {"material", "mix", "original"}
    -- local v = opt[math.random(1, #opt)]
    -- local palette = palettes[math.random(1, #palettes)]
    local v = opt[2]
    local palette = palettes[0]
    local h = tonumber(os.date("%H"))
    -- if h > 6 and h < 18 then
    --     vim.cmd("set background=light")
    -- else
    --     vim.cmd("set background=dark")
    -- end

    vim.g.gruvbox_material_invert_selection = 0
    vim.g.gruvbox_material_enable_italic = 1
    -- vim.g.gruvbox_material_italicize_strings = 1
    -- vim.g.gruvbox_material_invert_signs = 1
    vim.g.gruvbox_material_improved_strings = 1
    vim.g.gruvbox_material_improved_warnings = 1
    -- vim.g.gruvbox_material_contrast_dark=v
    vim.g.gruvbox_material_background = v
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_palette = palette
    vim.cmd("colorscheme gruvbox-material")
    vim.cmd("doautocmd ColorScheme")
end

function config.aurora()
    -- print("aurora")
    vim.cmd("colorscheme aurora")
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- remove background
    vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE") -- remove background
end

function config.sonokai()
    local opt = {
        "andromeda", "default", "andromeda", "shusia", "maia", "atlantis"
    }
    local v = opt[math.random(1, #opt)]
    vim.g.sonokai_style = v
    vim.g.sonokai_enable_italic = 1
    vim.g.sonokai_diagnostic_virtual_text = "colored"
    vim.g.sonokai_disable_italic_comment = 1
    vim.g.sonokai_current_word = "underline"
    vim.cmd([[colorscheme sonokai]])
    vim.cmd([[hi CurrentWord guifg=#E3F467 guibg=#332248 gui=Bold,undercurl]])
    vim.cmd([[hi TSKeyword gui=Bold]])
end

function config.kangawa()
    require('kanagawa').setup({
        undercurl = true, -- enable undercurls
        commentStyle = "italic",
        functionStyle = "NONE",
        keywordStyle = "italic",
        statementStyle = "bold",
        typeStyle = "NONE",
        variablebuiltinStyle = "italic",
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        colors = {},
        overrides = {}
    })

    -- setup must be called before loading
    vim.cmd([[colorscheme kanagawa]])
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- remove background
    vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE") -- remove background
end

function config.tokyonight()
    local opt = {"storm", "night"}
    local v = math.random(1, #opt)
    vim.g.tokyonight_style = opt[v]
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    vim.g.tokyonight_colors = {hint = "orange", error = "#ae1960"}
end

return config
