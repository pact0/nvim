" PLUGINS
"######################################################################

call plug#begin('~/.vim/plugged')


Plug 'voldikss/vim-floaterm'

Plug 'folke/todo-comments.nvim'
Plug 'stephpy/vim-php-cs-fixer'

" Project management
" Plug 'airblade/vim-rooter'
Plug 'windwp/nvim-projectconfig'
Plug 'klen/nvim-config-local'

Plug 'andweeb/presence.nvim'
Plug 'Pocco81/AutoSave.nvim'


Plug 'bkad/CamelCaseMotion'


" git in vim

Plug 'Shatur/neovim-cmake'


Plug 'akinsho/nvim-toggleterm.lua'

" Tree shitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'tree-sitter/tree-sitter-cpp'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'nvim-neorg/tree-sitter-norg'
Plug 'David-Kunz/treesitter-unit'
Plug 'windwp/nvim-ts-autotag'
Plug 'p00f/nvim-ts-rainbow'
" Plug 'spywhere/detect-language.nvim'
Plug 'MDeiml/tree-sitter-markdown'
"auto close html tags
" <div></div>    ciwspan<esc>   <span></span>
Plug 'windwp/nvim-autopairs'
Plug 'MunifTanjim/nui.nvim'
" more text object
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'

" paste without newline gcp
Plug ''

" lsp Plugins
Plug 'RishabhRD/popfix'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'folke/lsp-colors.nvim'
" lsp helpers
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" completion
" snippets
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'andersevenrud/cmp-tmux'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'f3fora/cmp-spell'
Plug 'ray-x/cmp-treesitter'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'lukas-reineke/cmp-under-comparator'
Plug 'lukas-reineke/cmp-rg'


Plug 'styled-components/vim-styled-components'
" Plug 'SmiteshP/nvim-gps'

call plug#end()
