" Automatically download plugins
source $HOME/.vim/config/plugins.vim

set nobackup " Vim won't create backup files
set nowritebackup " and won't make them during writing

set nolinebreak " no autoinserting line break
set nowrap " no wrapping lines
"set wrap " wrapping lines

" spaces instead of tab
set expandtab
" how many spaces for each tab
set tabstop=2
" spaces for indention
set shiftwidth=2
"set list
"set colorcolumn=80

" auto indentions
set autoindent
set smartindent

" Set relative number and assign it to ctrl + m for toggle
set relativenumber
"set nu
map <C-m> :set nu!<CR>

"Needed for a lot of cool stuff and plugins
set nocompatible

"File type plugin recognize files using extension
filetype plugin on

" Pathogen and Vundle is not needed in vim 8
" execute pathogen#infect()
syntax on

"Set interactive search
set incsearch

"Nerdtree
"Ctrl n to open/close nerdtree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='.'

" Vim Wiki configuration
" Setting up home directory and markdown as default VimWiki language
let g:vimwiki_list = [{'path': "$VIMWIKIHOME", 'syntax': 'markdown', 'ext': '.md'}]
" Highlight headers with different colors
let g:vimwiki_hl_headers = 1
" Highlight completed tasks
let g:vimwiki_hl_cb_checked = 1
" Do not shorten links
"let g:vimwiki_url_maxsave=0

" Loads specific color scheme for vimdiff
" colorscheme ron
" if &diff
"   colorscheme diffcolors
" endif

"set shellcmdflag=-lc

" Fugitive status line to show current branch name
set statusline+=%{fugitive#statusline()}
let g:ale_puppet_puppetlint_options='--no-variable_scope-check --no-autoloader_layout-check'
let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'

" Indentions
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
map <C-l> :IndentGuidesToggle<CR>
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=17
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=18
