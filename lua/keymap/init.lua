local map = require("keymap.bind").map
require("keymap.global")
local leader = " "

-- avoid clashing with leader as space
map("n", "<Space>", "<NOP>", {noremap = true, silent = true})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

local wk = require("which-key")

-- fugitive additional mappings
vim.cmd(([[
autocmd FileType fugitiveblame nmap <buffer> q gq
autocmd FileType fugitive nmap <buffer> q gq
autocmd FileType fugitive nmap <buffer> <Tab> =
]]))

-- treesitter-unit
vim.api.nvim_set_keymap('v', '<Space>',
                        ':lua require"treesitter-unit".select()<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('o', '<Space>',
                        ':<c-u>lua require"treesitter-unit".select()<CR>',
                        {noremap = true})

local map_normal_leader
local map_normal_g
map_normal_leader = {
    N = {"<cmd>NvimTreeToggle<CR>", "Toggle NvimTree"},
    f = {
        name = "Telescope",
        f = {"<cmd>Telescope git_files<CR>", "Search project files"},
        w = {"<cmd>Telescope live_grep theme=get_dropdown<CR>", "Search word"},
        c = {"<cmd>Telescope git_bcommits<CR>", "Browse blame commits"},
        r = {"<cmd>Telescope  lsp_references<CR>", "Browse LSP references"},
        S = {
            "<cmd>lua require('session-lens').search_session({theme_conf = {border = true},previewer = false,prompt_title = 'SESSIONS'})<CR>)",
            "Browse sessions"
        },
        d = {"<cmd>Telescope file_browser<CR>", "Browse directoriec"},
        h = {"<cmd>Telescope frecency<CR>", "Browse directoriec"}
    },
    h = {
        name = "Hunk git",
        s = {'<cmd>lua require"gitsigns".stage_hunk()<CR>', "Stage hunk"},
        u = {
            '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            "Undo stage hunk"
        },
        r = {'<cmd>lua require"gitsigns".reset_hunk()<CR>', "Reset hunk"},
        p = {'<cmd>lua require"gitsigns".preview_hunk()<CR>', "Preview hunk"},
        q = {
            '<cmd>lua do vim.cmd("copen") require"gitsigns".setqflist("all") end <CR>',
            "Add hunks to qf list"
        }
    },
    g = {
        name = "Git",
        b = {'<cmd>lua require"gitsigns".blame_line()<CR>', "Blame link"},
        s = {'<cmd>lua require"gitsigns".stage_buffer()<CR>', "Stage bugger"},
        h = {"<cmd>DiffviewFileHistory<CR>", "File history"},
        d = {
            name = "Diffing",
            c = {"<cmd>DiffviewOpen HEAD~1<CR>", "Last commit"},
            -- d = { "<cmd>Git diff %<CR>", "current file with current branch" },
            x = {"<cmd>DiffviewClose<CR>", "Close diffvire"},
            m = {
                "<cmd>DiffviewOpen origin/main<CR>",
                "Current file with main branch"
            }
        },
        l = {"<cmd>Telescope git_commits<CR>", "Git log"},
        g = {"<cmd>Neogit<CR>", "Git status"},
        z = {
            name = "Stashes",
            l = {"<cmd>Telescope git_stash<CR>", "List stashes"},
            z = {"<cmd>:Git stash<CR>", "run git stash"}
        },
        M = {"<cmd>GitMessenger<CR>", "GitMessenger"}
    },
    t = {
        name = "Tabs",
        a = {"<cmd>$tabnew<CR>", "Tab add"},
        c = {"<cmd>tabclose<CR>", "Tab close"},
        o = {"<cmd>tabonly<CR>", "Tab only"},
        n = {"<cmd>tabn<CR>", "Tab next"},
        p = {"<cmd>tabp<CR>", "Tab prev"}

    },
    Z = {M = {"<cmd>ZenMode<CR>", "Toggle ZenMode"}},
    x = {
        x = {"<cmd>Trouble<CR>", "Trouble"},
        w = {
            "<cmd>Trouble workspace_diagnostics<CR>",
            "Trouble workspace diagnostic"
        },
        d = {
            "<cmd>Trouble document_diagnostics<CR>",
            "Trouble document diagnostic"
        },
        l = {"<cmd>Trouble loclist<CR>", "Trouble loclist"},
        q = {"<cmd>Trouble quickfix<CR>", "Trouble quickfix"},
        r = {"<cmd>Trouble lsp_references<CR>", "Trouble lsp reference"}
    },
    S = {"<cmd>SymbolsOutline<CR>", "Symbols outline"},
    M = {"<cmd>MaximizerToggle<CR>", "MaximizerToggle"},
    T = {
        name = "TODO",
        T = {"<cmd>TodoTrouble<CR>", "TODO trouble"},
        F = {"<cmd>TodoTelescope<CR>", "TODO telescope"}
    }
}
wk.register(map_normal_leader, {prefix = "<leader>"})

map_normal_g = {
    d = {
        "<cmd>lua require('navigator.definition').definition()<CR>",
        "Go to definition"
    },
    D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration"},
    i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation"},
    r = {
        "<cmd>lua require('navigator.reference').reference()<CR>",
        "Browser references"
    },
    R = {
        "<cmd>lua require('navigator.reference').async_ref()<CR>",
        "Browse reference async"
    },
    -- '0' = {"<cmd>lua require('navigator.symbols').document_symbols()<CR>", "Document symbols"},
    W = {
        "<cmd>lua require('navigator.workspace').workspace_symbol()<CR>",
        "Workspace symbol"
    },
    p = {
        "<cmd>lua require('navigator.definition').definition_preview()<CR>",
        "Definition prev"
    },
    T = {"<cmd>lua require('navigator.treesitter').buf_ts()<CR>", "Treesitter "},
    -- r = {"<cmd>Telescope lsp_references<CR>", "References"}
    S = {"<cmd>SplitjoinSplit<CR>", "SplitjoinSplit"},
    J = {"<cmd>SplitjoinJoin<CR>", "SplitjoinJoin"}
}

wk.register(map_normal_g, {prefix = "g"})

local navigator_leader = {
    c = {
        a = {
            "<cmd>lua require('navigator.codeAction').code_action()<CR>",
            "Code action"
        }
    },
    w = {
        a = {
            "<cmd>lua require('navigator.workspace').add_workspace_folder()<CR>",
            "Add Workspace folder"
        },
        r = {
            "<cmd>lua require('navigator.workspace').remove_workspace_folder()<CR>",
            "Remove Workspace folder"
        }
    },
    g = {
        i = {
            "<cmd>lua require('navigator.cclshierarchy').incoming_calls()<CR>",
            "Incoming calls"
        },
        o = {
            "<cmd>lua require('navigator.cclshierarchy').outgoing_calls()<CR>",
            "Outgoing calls"
        }
    },
    k = {
        "<cmd>lua require('navigator.dochighlight').hi_symbol()<CR>",
        "Highlight symbol"
    }

}
wk.register(navigator_leader, {prefix = "<leader>"})

local open_brac = {
    t = {
        "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<CR>",
        "Prev trouble"
    },
    b = {"<Cmd>bprev<CR>", "Prev buffer"}
}
wk.register(open_brac, {prefix = "["})

local close_brac = {
    t = {
        "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<CR>",
        "Next trouble"
    },
    b = {"<Cmd>bnext<CR>", "Next buffer"}
}
wk.register(close_brac, {prefix = "]"})

-- ohers
map("i", "<C-r>", "<cmd>Telescope registers<CR>")
map("n", "<A-h>", "<CMD>lua require('Navigator').left()<CR>")
map("n", "<A-j>", "<CMD>lua require('Navigator').down()<CR>")
map("n", "<A-k>", "<CMD>lua require('Navigator').up()<CR>")
map("n", "<A-l>", "<CMD>lua require('Navigator').right()<CR>")

-- hop
map("n", "hw", "<cmd> HopWordAC<CR>")
map("n", "hW", "<cmd> HopWordBC<CR>")
map("n", "hl", "<cmd> HopLineStartAC<CR>")
map("n", "hL", "<cmd> HopLineStartBC<CR>")

map("n", "f", "<cmd> lua Line_ft('f')<CR>")
map("n", "F", "<cmd> lua Line_ft('F')<CR>")
map("n", "t", "<cmd> lua Line_ft('t')<CR>")
map("n", "T", "<cmd> lua Line_ft('T')<CR>")

map("n", "s", "<cmd> lua hop1(1)<CR>")
map("n", "S", "<cmd> lua hop1()<CR>")
map("x", "s", "<cmd> lua hop1(1)<CR>")
map("x", "S", "<cmd> lua hop1()<CR>")

map("n", "<A-s>", "<cmd> HopChar2AC<CR>")
map("n", "<A-S>", "<cmd> HopChar2BC<CR>")

map("v", "<A-s>", "<cmd> HopChar2AC<CR>")
map("v", "<A-S>", "<cmd> HopChar2BC<CR>")

map("n", "<leader>H", "<cmd> HopPattern<CR>")
map("n", "]p", "<cmd> HopPatternAC<CR>")
map("n", "[p", "<cmd> HopPatternBC<CR>")

vim.api.nvim_set_keymap("v", "<Leader>re",
                        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
                        {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rf",
                        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
                        {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rv",
                        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
                        {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>ri",
                        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
                        {noremap = true, silent = true, expr = false})


