require("pqf").setup {
    signs = {error = "", warning = "", info = "", hint = ""}
}

require('bqf').setup({preview = {delay_syntax = 0}})

               vim.g.qf_nowrap = false
                vim.g.qf_max_height = 20
vim.g["incsearch#auto_nohlsearch"] = true
vim.g["incsearch#magic"] = "\\v"
vim.g["incsearch#consistent_n_direction"] = true
vim.g["incsearch#do_not_save_error_message_history"] = true
