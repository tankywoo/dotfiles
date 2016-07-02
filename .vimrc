" Tanky Woo <me@tankywoo.com>
" https://tankywoo.com

" ===============================================================================
" Info
"   leader: default is `\`, detailed with `:help <leader>``
" ===============================================================================


" ===============================================================================
" General Configuration
" ===============================================================================

set nocompatible  " Use the vim's keyboard setting, not vi

set nu  " Set the line number
syntax on  " Syntax highlighting
"set autochdir  " Set the current dir as thr work dir
filetype on  " File type detection
filetype plugin on  " Loading the plugin files for specific file types
filetype indent on  " Loading the indent file for specific file types with

" Tab and Indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
"set expandtab  " Use the space to instead of tab
set autoindent  " Copy indent from current line when starting a new line
set smartindent
set cindent

" Seach and Match
set hlsearch  " Highlight the search result
set incsearch  " Real-time search
set ignorecase
set smartcase
set showmatch  " When a bracket is inserted, briefly jump to the matching one

" Display
set showmode  " Show the current mode
set t_Co=256  " If under tty, use 256

" Display tab and trail space
set list
set listchars=tab:>-,trail:.
" Not display above list
nmap <leader>l :set list!<CR>

" Other
set nobackup
set fileencodings=utf-8,gb18030,cp936,big5 " Set the encode
set pastetoggle=<F10>  " Bind `F10` to `:set paste`
set backspace=2 " same as ":set backspace=indent,eol,start" in vim7.4

" Press `shift` while selecting with the mouse can disable into visual mode
" In mac os, hold `alt/option` is easier
" ref: http://stackoverflow.com/questions/4608161/copy-text-out-of-vim-with-set-mouse-a-enabled
set mouse=a  " Enable mouse

set foldmethod=indent  " The kind of folding used for the current window
set foldlevel=99

" -------------------------------------------------------------------------------
" Enhanced
" -------------------------------------------------------------------------------

au BufRead,BufNewFile *.md set filetype=markdown  " .md default is modula2

" Execute python file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Auto add head info
" .py file auto add header
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1,  "# -*- coding: utf-8 -*-")
    call append(2,  "# Tanky Woo @ " . strftime('%Y-%m-%d', localtime()))
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

" .sh file auto add header
function HeaderBash()
    call setline(1, "#!/bin/bash")
    call append(1,  "# Tanky Woo @ " . strftime('%Y-%m-%d', localtime()))
    normal G
    normal o
endf
autocmd bufnewfile *.sh call HeaderBash()

" ref: http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
autocmd FileType html set shiftwidth=2|set expandtab
autocmd FileType htmljinja setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" ===============================================================================
" Vundle Configuration
" ===============================================================================

set nocompatible               " be iMproved, required
filetype off                   " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required!
Plugin 'gmarik/Vundle.vim'

" My Vundles here:

" Display
Plugin 'Lokaltog/vim-powerline'  " newer powerline is https://github.com/powerline/powerline
Plugin 'chriskempson/tomorrow-theme'
Plugin 'kien/rainbow_parentheses.vim'
"Plugin 'flazz/vim-colorschemes'  " themes collection

" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'mitsuhiko/vim-jinja'
"Plugin 'kevinw/pyflakes-vim'
"Plugin 'fs111/pydoc.vim'
"Plugin 'Pydiction'
"Plugin 'pep8'

" JavaScript
Plugin 'pangloss/vim-javascript'  " improved indentation
Plugin 'ternjs/tern_for_vim'  " js autocompletion

" Enhanced
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'AndrewRadev/splitjoin.vim'  " transition between multiline and single-line code
Plugin 'Tagbar'  " Tagbar is more powerful than 'taglist.vim'
Plugin 'Auto-Pairs'  " Auto-Pairs is more useful than AutoClose
"Plugin 'godlygeek/tabular'

" Others
"Plugin 'Shougo/neocomplete.vim'  " neocomplete need vim --with-lua
"Plugin 'SirVer/ultisnips'
" with ultisnips, Snippets are separated from the engine. Add this if you want them:
"Plugin 'honza/vim-snippets'
"Plugin 'mattn/emmet-vim'

if has('mac') || has('macunix')
    Plugin 'rizzatti/dash.vim'
endif

call vundle#end()             " required!
filetype plugin indent on     " required!
" To ignore plugin indent changes, instead use:
"filetype plugin on"
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" -------------------------------------------------------------------------------
" Lokaltog/vim-powerline
" -------------------------------------------------------------------------------
let g:Powerline_symbols = 'unicode' " compatible/unicode/fancy
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors"

" -------------------------------------------------------------------------------
" kien/rainbow_parentheses.vim
" -------------------------------------------------------------------------------
" always on
au VimEnter *.py,*.js,*.html,*.css,*.sls RainbowParenthesesToggle
au Syntax *.py,*.js,*.html,*.css,*.sls RainbowParenthesesLoadRound
au Syntax *.py,*.js,*.html,*.css,*.sls RainbowParenthesesLoadSquare
au Syntax *.py,*.js,*.html,*.css,*.sls RainbowParenthesesLoadBraces

" the outer layer is the last pair
" remove black for dark terminal
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 15

" -------------------------------------------------------------------------------
" davidhalter/jedi-vim
" -------------------------------------------------------------------------------
autocmd FileType python setlocal completeopt-=preview    " disable docstring
let g:jedi#completions_command = "<C-N>"

" -------------------------------------------------------------------------------
" nvie/vim-flake8
" -------------------------------------------------------------------------------
autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
let g:flake8_quickfix_height=5
let g:flake8_show_in_gutter=1
highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg
autocmd BufWritePost *.py call Flake8()

" ----------------------------------------------------------------------------
" ternjs/tern_for_vim
" ----------------------------------------------------------------------------
let tern_show_signature_in_pum = 1
let tern_show_argument_hints = 'on_hold'
autocmd FileType javascript nnoremap <leader>d :TernDef<CR>
autocmd FileType javascript setlocal omnifunc=tern#Complete

" ----------------------------------------------------------------------------
" scrooloose/nerdtree
" ----------------------------------------------------------------------------
nmap <leader>ne :NERDTreeToggle<CR>

" ----------------------------------------------------------------------------
" ervandew/supertab
" ----------------------------------------------------------------------------
set completeopt=longest,menu,preview
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" ----------------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>
map <leader>tb :TagbarToggle<CR>

"let g:tagbar_type_markdown = {
"    \ 'ctagstype': 'markdown',
"    \ 'ctagsbin' : '/Users/TankyWoo/.dotfiles/markdown2ctags.py',
"    \ 'ctagsargs' : '-f - --sort=yes',
"    \ 'kinds' : [
"        \ 's:sections',
"        \ 'i:images'
"    \ ],
"    \ 'sro' : '|',
"    \ 'kind2scope' : {
"        \ 's' : 'section',
"    \ },
"    \ 'sort': 0,
"\ }

" ----------------------------------------------------------------------------
" airblade/vim-gitgutter
" ----------------------------------------------------------------------------
let g:gitgutter_max_signs = 500
"let g:gitgutter_highlight_lines = 1
highlight clear SignColumn

" ----------------------------------------------------------------------------
" SirVer/ultisnips
" ----------------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ----------------------------------------------------------------------------
" rizzatti/dash.vim
" ----------------------------------------------------------------------------
" https://raw.githubusercontent.com/rizzatti/dash.vim/master/doc/dash.txt
let g:dash_map = {
	\ 'python' : ['py', 'python2', 'py3', 'python3']
	\ }
nmap <silent> <leader>da <Plug>DashSearch

" ----------------------------------------------------------------------------
" godlygeek/tabular
" ----------------------------------------------------------------------------
" use `Tab /|` to auto align '|'


"================"
" Color Settings "
" ==============="
set t_Co=256

if exists('+colorcolumn')
    " cc is only exist >= `Vim7.3`
    set cc=81 " Short for colorcolumn
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
hi ColorColumn ctermbg=lightgrey guibg=lightgrey  " Highlighter cc

try
    set background=dark
    colorscheme Tomorrow-Night-Bright
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

" for gui, such as macvim
if has("gui_running")
	set guifont=Monaco:h12
	set gcr=a:blinkon0  "Disable cursor blink
	set lines=60
	set columns=150
endif

" Highlight TODO/FIXME/XXX
highlight myTODO cterm=bold term=bold ctermbg=yellow ctermfg=black
match myTODO /\(TODO\|XXX\|FIXME\)/

" this options can be setted with colors, and must be put after colorscheme
set cursorline " Highlighter the current line
set cursorcolumn " Highlighter the vertical line"
hi search cterm=underline ctermfg=white
