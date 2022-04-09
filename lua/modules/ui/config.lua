local config = {}

function config.indentguides()
    require("indent_guides").setup({
        -- put your options in here
        indent_soft_pattern = "\\s"
    })
end

function config.scrollview()
    if vim.wo.diff then return end
    local w = vim.api.nvim_call_function("winwidth", {0})
    if w < 70 then return end

    vim.g.scrollview_column = 1
end

function config.blankline()
    require("indent_blankline").setup({
        enabled = true,
        -- char = "|",
        char_list = {"", "┊", "┆", "¦", "|", "¦", "┆", "┊", ""},
        filetype_exclude = {
            "help", "startify", "dashboard", "packer", "guihua", "NvimTree",
            "sidekick"
        },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        buftype_exclude = {"terminal", "dashboard"},
        space_char_blankline = " ",
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true,
        context_patterns = {
            "class", "return", "function", "method", "^if", "if", "^while",
            "jsx_element", "^for", "for", "^object", "^table", "block",
            "arguments", "if_statement", "else_clause", "jsx_element",
            "jsx_self_closing_element", "try_statement", "catch_clause",
            "import_statement", "operation_type"
        },
        bufname_exclude = {"README.md"}
    })
    -- useing treesitter instead of char highlight
    -- vim.g.indent_blankline_char_highlight_list =
    -- {"WarningMsg", "Identifier", "Delimiter", "Type", "String", "Boolean"}
end

function config.nvim_tree_setup()
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_width = 28
    vim.g.nvim_tree_git_hl = 1
    vim.g.nvim_tree_width_allow_resize = 1
    vim.g.nvim_tree_highlight_opened_files = 1
    vim.g.nvim_tree_icons = {
        default = "",
        symlink = "",
        git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌"
        },
        folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = ""
        }
    }
    vim.cmd([[autocmd Filetype NvimTree set cursorline]])
end

function config.nvim_tree()
    -- following options are the default
    require("nvim-tree").setup({
        -- disables netrw completely
        disable_netrw = true,
        -- hijack netrw window on startup
        hijack_netrw = true,
        -- open the tree when running this setup function
        open_on_setup = false,
        -- will not open on setup if the filetype is in this list
        ignore_ft_on_setup = {},
        -- closes neovim automatically when the tree is the last **WINDOW** in the view
        auto_close = false,
        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        open_on_tab = false,
        -- hijack the cursor in the tree to put it at the start of the filename
        update_to_buf_dir = {
            -- enable the feature
            enable = true,
            -- allow to open the tree if it was previously closed
            auto_open = true
        },
        hijack_cursor = false,
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        update_cwd = false,
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
            -- enables the feature
            enable = true,
            -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
            -- only relevant when `update_focused_file.enable` is true
            update_cwd = false,
            -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
            -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
            ignore_list = {}
        },
        -- configuration options for the system open command (`s` in the tree by default)
        system_open = {
            -- the command to run this, leaving nil should work in most cases
            cmd = nil,
            -- the command arguments as a list
            args = {}
        },
        diagnostics = {
            enable = true,
            icons = {hint = "", info = "", warning = "", error = ""}
        },
        filters = {dotfiles = true, custom = {}},
        view = {
            -- width of the window, can be either a number (columns) or a string in `%`
            width = 30,
            -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
            side = "left",
            -- if true the tree will resize itself after opening a file
            auto_resize = false,
            mappings = {
                -- custom only false will merge the list with the default mappings
                -- if true, it will only use your list to set the mappings
                custom_only = false,
                -- list of mappings to set on the tree manually
                list = {}
            }
        }
    })
end

function config.wilder()
    vim.cmd([[
    call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })]])

    vim.cmd([[call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#python_file_finder_pipeline({
      \       'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
      \       'dir_command': ['fd', '-td'],
      \     }),
      \     wilder#substitute_pipeline({
      \       'pipeline': wilder#python_search_pipeline({
      \         'skip_cmdtype_check': 1,
      \         'pattern': wilder#python_fuzzy_pattern({
      \           'start_at_boundary': 0,
      \         }),
      \       }),
      \     }),
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': has('nvim') ? wilder#lua_fzy_filter() : wilder#vim_fuzzy_filter(),
      \     }),
      \     [
      \       wilder#check({_, x -> empty(x)}),
      \       wilder#history(),
      \     ],
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern({
      \         'start_at_boundary': 0,
      \       }),
      \     }),
      \   ),
      \ ])
let s:highlighters = [
      \ wilder#pcre2_highlighter(),
      \ wilder#lua_fzy_highlighter(),
      \ ]
let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'border': 'rounded',
      \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
      \ 'highlighter': s:highlighters,
      \ 'left': [
      \   ' ',
      \   wilder#popupmenu_devicons(),
      \   wilder#popupmenu_buffer_flags({
      \     'flags': ' a + ',
      \     'icons': {'+': '', 'a': '', 'h': ''},
      \   }),
      \ ],
      \ 'right': [
      \   ' ',
      \   wilder#popupmenu_scrollbar(),
      \ ],
      \ }))
let s:wildmenu_renderer = wilder#wildmenu_renderer({
      \ 'highlighter': s:highlighters,
      \ 'separator': ' · ',
      \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
      \ 'right': [' ', wilder#wildmenu_index()],
      \ })
call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': s:popupmenu_renderer,
      \ '/': s:popupmenu_renderer,
      \ 'substitute': s:wildmenu_renderer,
      \ }))]])
end

function config.tabby()
    require("tabby").setup({
        tabline = require("tabby.presets").active_wins_at_tail
    })
end


function config.windline()
  if not packer_plugins["nvim-web-devicons"].loaded then
    packer_plugins["nvim-web-devicons"].loaded = true
    require("packer").loader("nvim-web-devicons")
  end

  -- require('wlfloatline').toggle()
end

return config;
