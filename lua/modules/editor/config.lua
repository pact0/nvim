local config = {}

local esc = function(cmd)
    return vim.api.nvim_replace_termcodes(cmd, true, false, true)
end

function config.hexokinase()
    vim.g.Hexokinase_optInPatterns = {
        "full_hex", "triple_hex", "rgb", "rgba", "hsl", "hsla", "colour_names"
    }
    vim.g.Hexokinase_highlighters = {
        "virtual", "sign_column", -- 'background',
        "backgroundfull"
        -- 'foreground',
        -- 'foregroundfull'
    }
end

function config.lightspeed()
    -- you can configure Hop the way you like here; see :h hop-config
    require"lightspeed".setup {
        jump_to_first_match = true,
        jump_on_partial_input_safety_timeout = 400,
        -- This can get _really_ slow if the window has a lot of content,
        -- turn it on only if your machine can always cope with it.
        highlight_unique_chars = false,
        grey_out_search_area = true,
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 5,
        full_inclusive_prefix_key = '<c-x>',
        -- For instant-repeat, pressing the trigger key again (f/F/t/T)
        -- always works, but here you can specify additional keys too.
        instant_repeat_fwd_key = ';',
        instant_repeat_bwd_key = ':',
        -- By default, the values of these will be decided at runtime,
        -- based on `jump_to_first_match`.
        labels = nil,
        cycle_group_fwd_key = ']',
        cycle_group_bwd_key = '['
    }
    function repeat_ft(reverse)
        local ls = require 'lightspeed'
        ls.ft['instant-repeat?'] = true
        ls.ft:to(reverse, ls.ft['prev-t-like?'])
    end
    vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>',
                            {noremap = true, silent = true})
    vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>',
                            {noremap = true, silent = true})
    -- vim.cmd([[nunmap s]])
    -- vim.cmd([[vunmap s]])
    -- local bind = require("keymap.bind")
    -- local keys = {
    --   ["n|s"] = map_cr("HopChar1AC"),
    --   ["n|S"] = map_cr("HopChar1BC"),
    -- }
    -- bind.nvim_load_mapping(keys)
end

function config.comment()
    require('Comment').setup({
        extended = true,
        pre_hook = function(ctx)
            -- print("ctx", vim.inspect(ctx))
            -- Only update commentstring for tsx filetypes
            if vim.bo.filetype == 'typescriptreact' or vim.bo.filetype ==
                'javascript' or vim.bo.filetype == 'css' or vim.bo.filetype ==
                'html' then
                require('ts_context_commentstring.internal').update_commentstring()
            end
        end,
        post_hook = function(ctx)
            -- lprint(ctx)
            if ctx.range.scol == -1 then
                -- do something with the current line
            else
                -- print(vim.inspect(ctx), ctx.range.srow, ctx.range.erow, ctx.range.scol, ctx.range.ecol)
                if ctx.range.ecol > 400 then ctx.range.ecol = 1 end
                if ctx.cmotion > 1 then
                    -- 322 324 0 2147483647
                    vim.fn.setpos("'<", {0, ctx.range.srow, ctx.range.scol})
                    vim.fn.setpos("'>", {0, ctx.range.erow, ctx.range.ecol})
                    vim.cmd([[exe "norm! gv"]])
                end
            end
        end
    })
end

function config.neorg()
    local loader = require"packer".loader
    if not packer_plugins['nvim-treesitter'].loaded then
        loader("nvim-treesitter")
    end
    if not packer_plugins['neorg-telescope'].loaded then
        loader("telescope.nvim")
        loader("neorg-telescope")
    end

    require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.norg.concealer"] = {}, -- Allows for use of icons
            ["core.norg.dirman"] = { -- Manage your directories with Neorg
                config = {workspaces = {my_workspace = "~/neorg"}}
            },
            ["core.keybinds"] = { -- Configure core.keybinds
                config = {
                    default_keybinds = true, -- Generate the default keybinds
                    neorg_leader = "<Leader>o" -- This is the default if unspecified
                }
            },
            ["core.norg.completion"] = {config = {engine = "nvim-cmp"}},
            ["core.integrations.telescope"] = {} -- Enable the telescope module
        }
    }
    local neorg_callbacks = require("neorg.callbacks")

    neorg_callbacks.on_event("core.keybinds.events.enable_keybinds",
                             function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
            n = { -- Bind keys in normal mode
                {"<C-s>", "core.integrations.telescope.find_linkable"}
            },

            i = { -- Bind in insert mode
                {"<C-l>", "core.integrations.telescope.insert_link"}
            }
        }, {silent = true, noremap = true})
    end)

end

function config.hlslens()
    -- body
    -- vim.cmd([[packadd nvim-hlslens]])
    vim.cmd(
        [[noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR> <Cmd>lua require('hlslens').start()<CR>]])
    vim.cmd(
        [[noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR> <Cmd>lua require('hlslens').start()<CR>]])
    vim.cmd([[noremap * *<Cmd>lua require('hlslens').start()<CR>]])
    vim.cmd([[noremap # #<Cmd>lua require('hlslens').start()<CR>]])
    vim.cmd([[noremap g* g*<Cmd>lua require('hlslens').start()<CR>]])
    vim.cmd([[noremap g# g#<Cmd>lua require('hlslens').start()<CR>]])
    vim.cmd([[nnoremap <silent> <leader>l :noh<CR>]])
    require("hlslens").setup({
        calm_down = true,
        -- nearest_only = true,
        nearest_float_when = "always"
    })
    vim.cmd([[aug VMlens]])
    vim.cmd([[au!]])
    vim.cmd([[au User visual_multi_start lua require('utils.vmlens').start()]])
    vim.cmd([[au User visual_multi_exit lua require('utils.vmlens').exit()]])
    vim.cmd([[aug END]])
end

-- Exit                  <Esc>       quit VM
-- Find Under            <C-n>       select the word under cursor
-- Find Subword Under    <C-n>       from visual mode, without word boundaries
-- Add Cursor Down       <M-Down>    create cursors vertically
-- Add Cursor Up         <M-Up>      ,,       ,,      ,,
-- Select All            \\A         select all occurrences of a word
-- Start Regex Search    \\/         create a selection with regex search
-- Add Cursor At Pos     \\\         add a single cursor at current position
-- Reselect Last         \\gS        reselect set of regions of last VM session

-- Mouse Cursor    <C-LeftMouse>     create a cursor where clicked
-- Mouse Word      <C-RightMouse>    select a word where clicked
-- Mouse Column    <M-C-RightMouse>  create a column, from current cursor to
--                                   clicked position

return config
