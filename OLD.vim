let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/setters.vim
"lua require('pack')
" needs to be first before plugins init

lua require('core')
lua require('plugins')


" let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh', "CMakeLists.txt",'compose.json', 'package.json' ]
" let g:rooter_manual_only = 1


" let g:Hexokinase_highlighters = ['foregroundfull'] */
"/* let g:Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla" */

"/* let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy'] */

" If php-cs-fixer is in $PATH, you don't need to define line below
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
let g:php_cs_fixer_path = "/home/pacto/.config/composer/vendor/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar

" If you use php-cs-fixer version 1.x
let g:php_cs_fixer_level = "symfony"                   " options: --level (default:symfony)
let g:php_cs_fixer_config = "default"                  " options: --config
" If you want to define specific fixers:
"let g:php_cs_fixer_fixers_list = "linefeed,short_tag" " options: --fixers
"let g:php_cs_fixer_config_file = '.php_cs'            " options: --config-file
" End of php-cs-fixer version 1 config params

" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
"let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
"let g:php_cs_fixer_config_file = '.php_cs' " options: --config
" End of php-cs-fixer version 2 config params

let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 0     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
