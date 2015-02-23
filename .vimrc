" Tanky Woo <me@tankywoo.com>
" https://tankywoo.com

"========="
" General "
"========="
set nu " Set the line number
syntax on " Syntax highlighting
"set autochdir " Set the current dir as thr work dir
set hlsearch " Highlight the search result
set incsearch " Real-time search
" Disabled by `vundle`
"filetype on " File type detection
"filetype plugin on " Loading the plugin files for specific file types
"filetype indent on " Loading the indent file for specific file types with
set foldmethod=indent " The kind of folding used for the current window 
set foldlevel=99
set nocompatible " Use the vim's keyboard setting, not vi
set cindent
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent " Copy indent from current line when starting a new line
set softtabstop=4
set smartindent shiftwidth=4
"set expandtab " Use the space to instead of tab
set smartindent
set showmatch " When a bracket is inserted, briefly jump to the matching one
set showmode " Show the mode
set nobackup " No backup
set cursorline " Highlighter the current line
"hi cursorline gui=UNDERLINE cterm=UNDERLINE
set fileencodings=utf-8,gb18030,cp936,big5 " Set the encode
set t_Co=256 " If under tty, use 256
set pastetoggle=<F10> "" Bind `F10` to `:set paste`
set backspace=2 " same as ":set backspace=indent,eol,start" in vim7.4

" Display `tab` and `trail space`
set list
set listchars=tab:>-,trail:.

" NOTE: vim <leader> default is `\`, can `:help <leader>` to see more.

" Not display above list
nmap <leader>l :set list!<CR>

" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" cc is only exist >= `Vim7.3`
if exists('+colorcolumn')
    set cc=81 " Short for colorcolumn
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
hi ColorColumn ctermbg=lightgrey guibg=lightgreya  " Highlighter cc

" Auto add head info
" .py file auto add header
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1,  "# -*- coding: utf-8 -*-")
    call append(2,  "# Tanky Woo @ " . strftime('%Y-%m-%d', localtime()))
    normal G
    normal o
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

" .sh file auto add header
function HeaderBash()
    call setline(1, "#!/bin/bash")
    call append(1,  "# Tanky Woo @ " . strftime('%Y-%m-%d %T', localtime()))
    normal G
    normal o
    normal o
endf
autocmd bufnewfile *.sh call HeaderBash()

"======================"
" Bundle Configuration "
"======================"
set nocompatible               " be iMproved, required
filetype off                   " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required! 
Bundle 'gmarik/Vundle.vim'

" My Bundles here:

" original repos on github
" newer powerline is https://github.com/powerline/powerline
Bundle 'Lokaltog/vim-powerline'
Bundle 'chriskempson/tomorrow-theme'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'nvie/vim-flake8'
Bundle 'davidhalter/jedi-vim'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/nerdtree'
Bundle 'mitsuhiko/vim-jinja'
"Bundle 'ervandew/supertab'
" neocomplete need vim --with-lua
"Bundle 'Shougo/neocomplete.vim'
"Bundle 'kevinw/pyflakes-vim'
" doc: https://github.com/vim-scripts/pydoc.vim
"Bundle 'fs111/pydoc.vim'

" vim-scripts repos
" Tagbar is more powerful than 'taglist.vim'
Bundle 'Tagbar'
" `Auto-Pairs` is more useful than `AutoClose`
" TODO need to research
Bundle 'Auto-Pairs'
"Bundle 'pep8'
"Bundle 'TaskList.vim'
" `snipMate` will conflict with `PyDiction`, Google
"Bundle 'snipMate'
"Bundle 'ZenCoding.vim'
"Bundle 'Pydiction'
"Bundle 'Color-Scheme-Explorer'
"Bundle 'Jinja'

" non github repos

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

"=============================="
" Vundle Plugins Configuration "
"=============================="
" Tagbar
map <leader>tb :TagbarToggle<CR>
"map <leader>tbc :TagbarClose<CR>
nmap <F8> :TagbarToggle<CR>

" NERDTree
nmap <leader>ne :NERDTreeToggle<CR>

" vim-powerline
let g:Powerline_symbols = 'unicode' " compatible/unicode/fancy
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors"
au BufRead,BufNewFile *.md set filetype=markdown  " .md default is modula2

" Better Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" davidhalter/jedi-vim
autocmd FileType python setlocal completeopt-=preview    " disable docstring
let g:jedi#completions_command = "<C-N>"

" tabular
" use `Tab /|` to auto align '|'

" vim-flake8
autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
let g:flake8_quickfix_height=5
let g:flake8_show_in_gutter=1
highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg
"autocmd BufWritePost *.py call Flake8()

" TagList
" In Mac, use brew install ctags and specified the command path
"let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
"map <F7> :Tlist<CR>

" TaskList
"map <leader>tl :TaskList<CR>

" PyDiction
"let g:pydiction_location = '/home/tankywoo/.vim/bundle/Pydiction/complete-dict' " TODO
"let g:pydiction_menu_height = 10

" neocomplcache
"let g:neocomplcache_enable_at_startup = 1

"set completeopt=longest,menu,preview
"let g:SuperTabDefaultCompletionType = "<c-n>"

" Flake8
"autocmd BufWritePost *.py call Flake8()
"let g:flake8_builtins="_,apply"

" pep8
"let g:pep8_map='<C-k>'


"================"
" Color Settings "
" ==============="
set t_Co=256

try
    set background=dark
    colorscheme Tomorrow-Night-Bright
    "colorscheme desert
    "highlight Nornal ctermbg=NONE
    "highlight NonText ctermbg=NONE
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

" Highlight TODO/FIXME/XXX
highlight myTODO cterm=bold term=bold ctermbg=yellow ctermfg=black
match myTODO /\(TODO\|XXX\|FIXME\)/
