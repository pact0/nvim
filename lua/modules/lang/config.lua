local config = {}
local key_maps = {
    {
        key = '<Leader>gi',
        func = "require('navigator.cclshierarchy').incoming_calls()"
    }, {
        key = '<Leader>go',
        func = "require('navigator.cclshierarchy').outgoing_calls()"
    }, {key = 'gr', func = "require('navigator.reference').reference()"},
    {key = 'Gr', func = "require('navigator.reference').async_ref()"},
    {mode = 'i', key = '<M-k>', func = 'signature_help()'},
    {key = '<c-k>', func = 'signature_help()'},
    {key = 'g0', func = "require('navigator.symbols').document_symbols()"},
    {key = 'gW', func = "require('navigator.workspace').workspace_symbol()"},
    {key = '<c-]>', func = "require('navigator.definition').definition()"},
    {key = 'gD', func = "declaration({ border = 'rounded', max_width = 80 })"},
    {key = 'gp', func = "require('navigator.definition').definition_preview()"},
    {key = '<Leader>gt', func = "require('navigator.treesitter').buf_ts()"},
    {key = '<Leader>gT', func = "require('navigator.treesitter').bufs_ts()"}, {
        key = 'K',
        func = 'hover({ popup_opts = { border = single, max_width = 80 }})'
    }, {
        key = '<Space>ca',
        mode = 'n',
        func = "require('navigator.codeAction').code_action()"
    }, {key = '<Space>cA', mode = 'v', func = 'range_code_action()'},
    -- { key = '<Leader>re', func = 'rename()' },
    {key = '<Space>rn', func = "require('navigator.rename').rename()"},
    {key = '<Leader>gi', func = 'incoming_calls()'},
    {key = '<Leader>go', func = 'outgoing_calls()'},
    {key = 'gi', func = 'implementation()'},
    {key = '<Space>D', func = 'type_definition()'},
    {key = 'gL', func = "require('navigator.diagnostics').show_diagnostics()"},
    {
        key = 'gG',
        func = "require('navigator.diagnostics').show_buf_diagnostics()"
    }, {
        key = '<Leader>dt',
        func = "require('navigator.diagnostics').toggle_diagnostics()"
    }, {
        key = ']d',
        func = "diagnostic.goto_next({ border = 'rounded', max_width = 80})"
    }, {
        key = '[d',
        func = "diagnostic.goto_prev({ border = 'rounded', max_width = 80})"
    }, {key = ']r', func = "require('navigator.treesitter').goto_next_usage()"},
    {key = '[r', func = "require('navigator.treesitter').goto_previous_usage()"},
    {key = '<C-LeftMouse>', func = 'definition()'},
    {key = 'g<LeftMouse>', func = 'implementation()'},
    {key = '<Leader>k', func = "require('navigator.dochighlight').hi_symbol()"},
    {
        key = '<Space>wa',
        func = "require('navigator.workspace').add_workspace_folder()"
    }, {
        key = '<Space>wr',
        func = "require('navigator.workspace').remove_workspace_folder()"
    }, {key = '<Space>ff', func = 'formatting()', mode = 'n'},
    {key = '<Space>ff', func = 'range_formatting()', mode = 'v'}, {
        key = '<Space>wl',
        func = "require('navigator.workspace').list_workspace_folders()"
    }, {
        key = '<Space>la',
        mode = 'n',
        func = "require('navigator.codelens').run_action()"
    }
}

function config.nvim_treesitter() require("modules.lang.treesitter").treesitter() end

function config.treesitter_obj()
    require("modules.lang.treesitter").treesitter_obj()
end

function config.treesitter_ref()
    require("modules.lang.treesitter").treesitter_ref()
end

function config.refactor()
    local refactor = require("refactoring")
    refactor.setup({})

    _G.ts_refactors = function()
        -- telescope refactoring helper
        local function _refactor(prompt_bufnr)
            local content =
                require("telescope.actions.state").get_selected_entry(
                    prompt_bufnr)
            require("telescope.actions").close(prompt_bufnr)
            require("refactoring").refactor(content.value)
        end

        local opts = require("telescope.themes").get_cursor() -- set personal telescope options
        require("telescope.pickers").new(opts, {
            prompt_title = "refactors",
            finder = require("telescope.finders").new_table({
                results = require("refactoring").get_refactors()
            }),
            sorter = require("telescope.config").values.generic_sorter(opts),
            attach_mappings = function(_, map)
                map("i", "<CR>", _refactor)
                map("n", "<CR>", _refactor)
                return true
            end
        }):find()
    end
end

function config.tsubject()
    require("nvim-treesitter.configs").setup({
        textsubjects = {
            enable = true,
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer"
            }
        }
    })
end

function config.outline()
    vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = true,
        position = "right",
        relative_width = true,
        width = 25,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "Pmenu",
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {"<Esc>", "q"},
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a"
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
            File = {icon = "", hl = "TSURI"},
            Module = {icon = "", hl = "TSNamespace"},
            Namespace = {icon = "", hl = "TSNamespace"},
            Package = {icon = "", hl = "TSNamespace"},
            Class = {icon = "𝓒", hl = "TSType"},
            Method = {icon = "ƒ", hl = "TSMethod"},
            Property = {icon = "", hl = "TSMethod"},
            Field = {icon = "", hl = "TSField"},
            Constructor = {icon = "", hl = "TSConstructor"},
            Enum = {icon = "ℰ", hl = "TSType"},
            Interface = {icon = "ﰮ", hl = "TSType"},
            Function = {icon = "", hl = "TSFunction"},
            Variable = {icon = "", hl = "TSConstant"},
            Constant = {icon = "", hl = "TSConstant"},
            String = {icon = "𝓐", hl = "TSString"},
            Number = {icon = "#", hl = "TSNumber"},
            Boolean = {icon = "⊨", hl = "TSBoolean"},
            Array = {icon = "", hl = "TSConstant"},
            Object = {icon = "⦿", hl = "TSType"},
            Key = {icon = "🔐", hl = "TSType"},
            Null = {icon = "NULL", hl = "TSType"},
            EnumMember = {icon = "", hl = "TSField"},
            Struct = {icon = "𝓢", hl = "TSType"},
            Event = {icon = "🗲", hl = "TSType"},
            Operator = {icon = "+", hl = "TSOperator"},
            TypeParameter = {icon = "𝙏", hl = "TSParameter"}
        }
    }
end

function config.sqls() end

function config.aerial()

    -- Aerial does not set any mappings by default, so you'll want to set some up
end

function config.syntax_folding()
    local fname = vim.fn.expand("%:p:f")
    local fsize = vim.fn.getfsize(fname)
    if fsize > 1024 * 1024 then
        print("disable syntax_folding")
        vim.api.nvim_command("setlocal foldmethod=indent")
        return
    end
    vim.api.nvim_command("setlocal foldmethod=expr")
    vim.api.nvim_command("setlocal foldexpr=nvim_treesitter#foldexpr()")
end

-- https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

local path = vim.split(package.path, ";")

table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

function config.navigator()
    local lsp_path = require 'nvim-lsp-installer.path'
    local install_root_dir = lsp_path.concat {
        vim.fn.stdpath 'data', 'lsp_servers'
    }

    local single = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}

    -- local efm_cfg = require("modules.lang.efm").efm

    -- loader('aerial.nvim')
    local nav_cfg = {
        debug = plugin_debug(),
        width = 0.7,
        lsp_installer = true,
        on_attach = function(client, bufnr)
            -- require'aerial'.on_attach(client, bufnr)
        end,
        border = single, -- "single",
        ts_fold = true,
        -- external = true, -- true: enable for goneovim multigrid otherwise false
        lsp_signature_help = true

        -- default_mapping = false,
        -- keymaps = key_maps, -- a list of key maps

        -- lsp = {
        --     cpp = {cmd = {install_root_dir .. '/clangd/clangd/bin/clangd'}},
        --     c = {cmd = {install_root_dir .. '/clangd/clangd/bin/clangd'}},
        --     tsserver = { cmd = {install_root_dir .. '/tsserver/node_modules/typescript/bin/tsserver'} },
        --     sumneko_lua = {
        --         cmd = {
        --             install_root_dir ..
        --                 'sumneko_lua/extension/server/bin/lua-language-server'
        --         }
        --     }
        -- },
        -- keymaps = {
        --     {mode = 'i', key = '<M-k>', func = 'signature_help()'},
        --     {key = "<c-i>", func = "signature_help()"}
        -- }
        -- icons = {
        --   diagnostic_err = "",
        --   diagnostic_warn = "",
        --   diagnostic_info = [[]],
        --   diagnostic_hint = [[ﯦ]],
        --   diagnostic_virtual_text = ""
        -- }
    }
    require("navigator").setup(nav_cfg)
end

function config.playground()
    require("nvim-treesitter.configs").setup({
        playground = {
            enable = true,
            disable = {},
            updatetime = 50, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = true -- Whether the query persists across vim sessions
        }
    })
end

function config.dap()
    -- dap.adapters.node2 = {
    --   type = 'executable',
    --   command = 'node',
    --   args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
    -- }
    -- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
    -- vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
    -- require('telescope').load_extension('dap')
    -- vim.g.dap_virtual_text = true
end

return config
