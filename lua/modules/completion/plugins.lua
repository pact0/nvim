local completion = {}
local conf = require("modules.completion.config")

-- loading sequence LuaSnip -> nvim-cmp -> cmp_luasnip -> cmp-nvim-lua -> cmp-nvim-lsp ->cmp-buffer -> friendly-snippets
completion["hrsh7th/nvim-cmp"] = {
  -- opt = true,
  -- event = "InsertEnter", -- InsertCharPre
  -- ft = {'lua', 'markdown',  'yaml', 'json', 'sql', 'vim', 'sh', 'sql', 'vim', 'sh'},
  after = { "LuaSnip" }, -- "nvim-snippy",
  requires = {
    { "hrsh7th/cmp-buffer", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-calc", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-path", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp", opt = true },
    { "ray-x/cmp-treesitter", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", opt = true },
    { "f3fora/cmp-spell", after = "nvim-cmp", opt = true },
    { "octaltree/cmp-look", after = "nvim-cmp", opt = true },
    -- {"quangnguyen30192/cmp-nvim-ultisnips", event = "InsertCharPre", after = "nvim-cmp", opt=true },
    { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
    -- {"tzachar/cmp-tabnine", opt = true}
  },
  config = conf.nvim_cmp,
}

-- can not lazyload, it is also slow...
completion["L3MON4D3/LuaSnip"] = { -- need to be the first to load
  event = "InsertEnter",
  requires = { "rafamadriz/friendly-snippets", event = "InsertEnter" }, -- , event = "InsertEnter"
  config = conf.luasnip,
}
completion["kristijanhusak/vim-dadbod-completion"] = {
  event = "InsertEnter",
  ft = { "sql" },
  setup = function()
    vim.cmd([[autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni]])
    -- vim.cmd([[autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]])
    -- body
  end,
}


completion["mattn/emmet-vim"] = {
  event = "InsertEnter",
  ft = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "vue",
    "typescript",
    "typescriptreact",
    "scss",
    "sass",
    "less",
    "jade",
    "haml",
    "elm",
  },
  setup = conf.emmet,
}

completion["windwp/nvim-autopairs"] = {
  -- keys = {{'i', '('}},
  -- keys = {{'i'}},
  after = { "nvim-cmp" }, -- "nvim-treesitter", nvim-cmp "nvim-treesitter", coq_nvim
  -- event = "InsertEnter",  --InsertCharPre
  -- after = "hrsh7th/nvim-compe",
  config = conf.autopairs,
  opt = true,
}


return completion
