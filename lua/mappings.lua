local map = require("utils").map
local leader = "<space>"

-- map("n", "/", "<Plug>(incsearch-forward)", {noremap = false})
-- map("n", "?", "<Plug>(incsearch-backward)", {noremap = false})
-- map("n", "n", "<Plug>(incsearch-nohl-n)zz", {noremap = false})
-- map("n", "N", "<Plug>(incsearch-nohl-N)zz", {noremap = false})
-- map("n", "*", "<Plug>(incsearch-nohl-*)zz", {noremap = false})
-- map("n", "#", "<Plug>(incsearch-nohl-#)zz", {noremap = false})
-- map("n", "g*", "<Plug>(incsearch-nohl-g*)zz", {noremap = false})
-- map("n", "g#", "<Plug>(incsearch-nohl-g#)zz", {noremap = false})
--
map("n", "x", '"_x')
map("n", leader .. "oo", "o<esc>k")
map("n", leader .. "O", "O<esc>j")

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
map('n', 'Q', '@@')
-- Split line with X
map('n', 'X',
    ':keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>',
    {silent = true})
-- Open the current file's directory
map('n', '-', [[expand('%') == '' ? ':e ' . getcwd() . '<cr>' : ':e %:h<cr>']],
    {expr = true})

-- #region Navigator

-- ###

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'",
                        {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'",
                        {noremap = true, expr = true, silent = true})
map({"n", "o", "v"}, "H", "^")
map({"n", "o", "v"}, "L", "$")
map({"n", "v"}, "J", "5j")
map({"n", "v"}, "K", "5k")

-- map("n", leader .. "gd",
--     ":set nosplitright<CR>:execute 'Gvdiffsplit ' .. g:git_base<CR>:set splitright<CR>")
-- map("n", leader .. "gr", ":Gread<CR>")
-- map("n", leader .. "gb", ":Git blame<CR>")
-- map("n", leader .. "gs", ":Git<CR>")
-- map("n", leader .. "gm", "<Plug>(git-messenger)", {noremap = false})
-- map("n", leader .. "gc", ":0Gclog<CR>", {noremap = false})
-- map("n", leader .. "gn",
--     ":lua require('lists').change_active('Quickfix')<CR>:Git mergetool<CR>")
-- map("n", leader .. "gh", ":diffget //2<CR> :diffupdate<CR>")
-- map("n", leader .. "gl", ":diffget //3<CR> :diffupdate<CR>")

-- #visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "*", '"vygv:<C-U>/\\<<C-R>v\\><CR>')
map("v", "#", '"vygv:<C-U>?\\<<C-R>v\\><CR>')
-- #end visual mode

-- # quickfix
map("n", "<UP>", ":lua require('lists').move('up')<CR>zz", {silent = true})
map("n", "<DOWN>", ":lua require('lists').move('down')<CR>zz", {silent = true})
map("n", "<LEFT>", ":lua require('lists').move('left')<CR>", {silent = true})
map("n", "<RIGHT>", ":lua require('lists').move('right')<CR>", {silent = true})
map("n", leader .. "cf",
    "<Plug>(qf_qf_toggle_stay):lua require('lists').change_active('Quickfix')<CR>",
    {noremap = false, silent = true})
map("n", leader .. "v",
    "<Plug>(qf_loc_toggle_stay):lua require('lists').change_active('Location')<CR>",
    {noremap = false, silent = true})
map("n", leader .. "b", ":lua require('lists').toggle_active()<CR>")

-- map("n", leader .. "a",
--
--     ":lua require('lists').change_active('Quickfix')<CR>:Ack<space>")
-- # end quickfix

map("x", "iu", ':lua require"treesitter-unit".select()<CR>', {noremap = true})
map("x", "au", ':lua require"treesitter-unit".select(true)<CR>',
    {noremap = true})
map("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>',
    {noremap = true})
map("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>',
    {noremap = true})


map("n", "<CLEAR-1>", "<Plug>UnconditionalPasteLineAfter", {noremap = false})
map("n", "<CLEAR-2>", "<Plug>UnconditionalPasteLineBefore", {noremap = false})
map("n", "<CLEAR-3>", "<Plug>UnconditionalPasteCommaAfter", {noremap = false})
map("n", "<CLEAR-4>", "<Plug>UnconditionalPasteCommaBefore", {noremap = false})
map("n", "<CLEAR-5>", "<Plug>UnconditionalPasteCommaSingleQuoteAfter",
    {noremap = false})
map("n", "<CLEAR-6>", "<Plug>UnconditionalPasteCommaSingleQuoteBefore",
    {noremap = false})
map("n", "<CLEAR-7>", "<Plug>VimwikiIncrementListItem", {noremap = false})
map("n", "<CLEAR-8>", "<Plug>VimwikiDecrementListItem", {noremap = false})
map("n", "glp", "<Plug>UnconditionalPasteIndentedAfter", {noremap = false})
map("n", "glP", "<Plug>UnconditionalPasteIndentedBefore", {noremap = false})

------
map("n", leader .. leader,
    ":<C-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<CR>",
    {silent = true})
map("n", leader .. "<C-o>", ":lua require 'buffers'.close_others()<CR>")
map("n", leader .. "q", ":lua require 'buffers'.close()<CR>")
map("n", leader .. "w", ":update<CR>")
-- map("n", "]b", "<Cmd>bnext<CR>")
-- map("n", "[b", "<Cmd>bprev<CR>")

-- Around line: with leading and trailing whitespace
map('v', 'al', ':<c-u>silent! normal! 0v$<cr>', {silent = true})
map('o', 'al', ':normal val<cr>', {noremap = false, silent = true})

-- Inner line: without leading or trailing whitespace

map('v', 'il', ':<c-u>silent! normal! ^vg_<cr>', {silent = true})
map('o', 'il', ':normal vil<cr>', {noremap = false, silent = true})

-- Whole file, jump back with <c-o>

map('v', 'ae', [[:<c-u>silent! normal! m'gg0VG$<cr>]], {silent = true})
map('o', 'ae', ':normal Vae<cr>', {noremap = false, silent = true})

----------------------------------------------------------------
------------------------------DAP-------------------------------
-- vim.api.nvim_set_keymap("n", "[DAP]r", "<cmd>lua require'dap'.repl.open()<CR>",
--                         {})
--

map('n', leader .. "dda", ':lua require"debugHelper".attach()<CR>')
map('n', leader .. "ddb", ':lua require"dap".toggle_breakpoint()<CR>')
map('n', leader .. "ddB",
    ':lua require"dap".toggle_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>')
map('n', leader .. "ddc", ':lua require"dap".continue()<CR>')
map('n', leader .. "ddi", ':lua require"dap".step_into()<CR>')
map('n', leader .. "ddo", ':lua require"dap".step_over()<CR>')
map('n', leader .. "ddR", ':lua require"dap".restart()<CR>')
map('n', leader .. "dde", ':lua require"dap".disconnect()<CR>')
map('n', leader .. "dde", ':lua require"dap".disconnect()<CR>')
map('n', leader .. "ddU", ':lua require"dapui".toggle()<CR>')
map('n', leader .. "ddh", ':lua require"dap.ui.widgets".hover()<CR>')

--					Resize splits more quickly
-- ────────────────────────────────────────────────────
-- resize up and down
map('n', ';k', ':resize +3 <CR>', {noremap = true, silent = true})
map('n', ';j', ':resize -3 <CR>', {noremap = true, silent = true})
-- resize right and left
map('n', ';l', ':vertical resize +3 <CR>', {noremap = true, silent = true})
map('n', ';h', ':vertical resize -3 <CR>', {noremap = true, silent = true})

-- move selected line(s) up or down
-- map('v', 'J', ":m '>+1<CR>gv=gv", {noremap=true, silent=true})
-- map('v', 'K', ":m '<-2<CR>gv=gv", {noremap=true, silent=true})

-- Yank, delete and paste will use the x register
-- k.nnoremap {'y', '"xy'}
-- k.xnoremap {'y', '"xy'}
-- k.nnoremap {'Y', '"xy$'}
-- k.nnoremap {'d', '"xd'}
-- k.xnoremap {'d', '"xd'}
-- k.nnoremap {'D', '"xD'}
-- k.nnoremap {'p', '"xp'}
-- k.xnoremap {'p', '"xp'}
-- k.nnoremap {'P', '"xP'}

map("n", leader .. "u", "<cmd>MundoToggle<CR>")
map("n", leader .. "m", "<cmd>MaximizerToggle<CR>")

-- terminal
-- map("n", "<C-t>", "<cmd>FloatermToggle<CR>")
map("n", "<A-g>", "<cmd>FloatermNew! --disposable lazygit<CR>")

-- map("n", "]t", "<cmd>FloatermNext <CR>")
-- map("n", "[t", "<cmd>FloatermPrev<CR>")
