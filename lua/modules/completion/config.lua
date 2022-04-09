local global = require 'core.global'
local config = {}

local function is_prior_char_whitespace()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

function config.autopairs()
  local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
  if not has_autopairs then
    print("autopairs not loaded")

    local loader = require"packer".loader
    loader('nvim-autopairs')
    has_autopairs, autopairs = pcall(require, "nvim-autopairs")
    if not has_autopairs then
      print("autopairs not installed")
      return
    end
  end
  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  npairs.setup({
    disable_filetype = {"TelescopePrompt", "guihua", "guihua_rust", "clap_input"},
    autopairs = {enable = true},
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""), -- "[%w%.+-"']",
    enable_check_bracket_line = false,
    html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
    check_ts = true,
    ts_config = {
      lua = {'string'}, -- it will not add pair on that treesitter node
      -- go = {'string'},
      javascript = {'template_string'},
      java = false -- don't check treesitter on java
    },
    fast_wrap = {
      map = '<M-e>',
      chars = {'{', '[', '(', '"', "'", "`"},
      pattern = string.gsub([[ [%'%"%`%+%)%>%]%)%}%,%s] ]], '%s+', ''),
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      hightlight = 'Search'
    }
  })
  local ts_conds = require('nvim-autopairs.ts-conds')
  -- you need setup cmp first put this after cmp.setup()

  npairs.add_rules {
    Rule(" ", " "):with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({"()", "[]", "{}"}, pair)
    end), Rule("(", ")"):with_pair(function(opts)
      return opts.prev_char:match ".%)" ~= nil
    end):use_key ")", Rule("{", "}"):with_pair(function(opts)
      return opts.prev_char:match ".%}" ~= nil
    end):use_key "}", Rule("[", "]"):with_pair(function(opts)
      return opts.prev_char:match ".%]" ~= nil
    end):use_key "]", Rule("%", "%", "lua") -- press % => %% is only inside comment or string
    :with_pair(ts_conds.is_ts_node({'string', 'comment'})),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({'function'}))
  }

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

  if load_coq() then
    local remap = vim.api.nvim_set_keymap
    local npairs = require('nvim-autopairs')

    npairs.setup({map_bs = false})

    vim.g.coq_settings = {keymap = {recommended = false}}

    -- these mappings are coq recommended mappings unrelated to nvim-autopairs
    remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], {expr = true, noremap = true})
    remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], {expr = true, noremap = true})
    remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], {expr = true, noremap = true})
    remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], {expr = true, noremap = true})

    -- skip it, if you use another global object
    _G.MUtils = {}

    MUtils.CR = function()
      if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({'selected'}).selected ~= -1 then
          return npairs.esc('<c-y>')
        else
          -- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
          return npairs.esc('<c-g><c-g>') .. npairs.autopairs_cr()
        end
      else
        return npairs.autopairs_cr()
      end
    end
    remap('i', '<cr>', 'v:lua.MUtils.CR()', {expr = true, noremap = true})

    MUtils.BS = function()
      if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({'mode'}).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
      else
        return npairs.autopairs_bs()
      end
    end
    remap('i', '<bs>', 'v:lua.MUtils.BS()', {expr = true, noremap = true})
  end

  -- print("autopairs setup")
  -- skip it, if you use another global object

end

function config.nvim_cmp()
  local cmp = require('cmp')

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local luasnip = require("luasnip")
  local function tab(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      -- F("<Tab>")
      fallback()
    end
  end


  -- print("cmp setup")
  local comp_kind = nil
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
  end

  local sources = {
    {name = 'nvim_lsp'}, {name = 'luasnip'}, {name = 'treesitter', keyword_length = 2},
    {name = 'look', keyword_length = 4}
    -- {name = 'buffer', keyword_length = 4} {name = 'path'}, {name = 'look'},
    -- {name = 'calc'}, {name = 'ultisnips'} { name = 'snippy' }
  }
  if vim.o.ft == 'sql' then
    table.insert(sources, {name = 'vim-dadbod-completion'})
  end

  if vim.o.ft == 'norg' then
    table.insert(sources, {name = 'neorg'})
  end
  if vim.o.ft == 'markdown' then
    table.insert(sources, {name = 'spell'})
    table.insert(sources, {name = 'look'})
  end
  if vim.o.ft == 'lua' then
    table.insert(sources, {name = 'nvim_lua'})
  end
  if vim.o.ft == 'zsh' or vim.o.ft == 'sh' or vim.o.ft == 'fish' or vim.o.ft == 'proto' then
    table.insert(sources, {name = 'path'})
    table.insert(sources, {name = 'buffer', keyword_length = 3})
    table.insert(sources, {name = 'calc'})
  end
  cmp.setup {
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body)
        -- require 'snippy'.expand_snippet(args.body)
        -- vim.fn["UltiSnips#Anon"](args.body)
      end
    },
    completion = {
      autocomplete = {require("cmp.types").cmp.TriggerEvent.TextChanged},
      completeopt = "menu,menuone,noselect"
    },
    formatting = {
      format = function(entry, vim_item)
        -- print(vim.inspect(vim_item.kind))
        -- if cmp_kind == nil then
          -- TODO uncomment
          -- cmp_kind = require"navigator.lspclient.lspkind".cmp_kind
        -- end
        -- vim_item.kind = cmp_kind(vim_item.kind)

        vim_item.kind = vim.lsp.protocol.CompletionItemKind[vim_item.kind]
        vim_item.menu = ({
          buffer = " ﬘",
          nvim_lsp = " ",
          luasnip = " 🐍",
          treesitter = ' ',
          nvim_lua = " ",
          spell = ' 暈'
        })[entry.source.name]
        return vim_item
      end
    },
    -- documentation = {
    --   border = "rounded",
    -- },
    -- You must set mapping if you want.
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert
        }),
        ['<C-p>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert
        }),
        ['<Down>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
        }),
        ['<Up>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
        }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    },

    -- You should specify your *installed* sources.
    sources = sources,

    experimental = {ghost_text = true}
  }
  require"packer".loader("nvim-autopairs")
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

  -- require'cmp'.setup.cmdline(':', {sources = {{name = 'cmdline'}}})
  if vim.o.ft == 'clap_input' or vim.o.ft == 'guihua' or vim.o.ft == 'guihua_rust' then
    require'cmp'.setup.buffer {completion = {enable = false}}
  end
  vim.cmd("autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }")
  -- if vim.o.ft ~= 'sql' then
  --   require'cmp'.setup.buffer { completion = {autocomplete = false} }
  -- end
end

function config.vim_vsnip()
  vim.g.vsnip_snippet_dir = global.home .. "/.config/nvim/snippets"
end

function config.luasnip()
  local ls = require "luasnip"
  ls.config.set_config {history = true, updateevents = "TextChanged,TextChangedI"}
  require("luasnip.loaders.from_vscode").load {}

  vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
  vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

end

function config.emmet()
  vim.g.user_emmet_complete_tag = 1
  -- vim.g.user_emmet_install_global = 1
  vim.g.user_emmet_install_command = 0
  vim.g.user_emmet_mode = "a"
end

return config
