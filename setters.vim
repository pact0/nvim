"set guicursor=a:blinkon100
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175
"set guicursor=i-ci:hor10-Search
set relativenumber
set completeopt=menu,menuone,noinsert,noselect
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu rnu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
" set noshowmode
set signcolumn=yes
set isfname+=@-@
" set ls=0

" Give more space for displaying messages.
" delays and poor user experience.
set updatetime=50
set shortmess+=c
set colorcolumn=80
" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
set rtp +=~/.config/nvim
set mouse=a

" function! MyFoldText()
"     let line = getline(v:foldstart)
"     let foldedlinecount = v:foldend - v:foldstart + 1
"     return ' ⭐️ '. foldedlinecount . line
" endfunction
"set foldtext=MyFoldText()


" start with unfolded
" if this stops working try au BufRead * normal zR
set foldlevelstart=99
set encoding=UTF-8

" transparent background
set clipboard=unnamedplus
set termguicolors " this variable must be enabled for colors to be applied properly
