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

" cc is only exist in `Vim7.3`
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
""set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'kevinw/pyflakes-vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'fs111/pydoc.vim'
Bundle 'chriskempson/tomorrow-theme'
Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'nvie/vim-flake8'
Bundle 'davidhalter/jedi-vim'

" vim-scripts repos
" NOTE:
" `snipMate` will conflict with `PyDiction`, Google
" `Auto-Pairs` is more useful than `AutoClose`
Bundle 'pep8'
Bundle 'taglist.vim'
Bundle 'Tagbar'
Bundle 'TaskList.vim'
Bundle 'snipMate'
Bundle 'ZenCoding.vim'
Bundle 'Tabular'
Bundle 'Auto-Pairs'
Bundle 'Pydiction'
Bundle 'The-NERD-tree'
Bundle 'neocomplcache'
Bundle 'Color-Scheme-Explorer'
Bundle 'Jinja'

" non github repos


filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"=============================="
" Vundle Plugins Configuration "
"=============================="
" TagList
" In Mac, use brew install ctags and specified the command path
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
map <F7> :Tlist<CR>
" TaskList
map <leader>tl :TaskList<CR>
" Tagbar
map <leader>tb :Tagbar<CR>
map <leader>tbc :TagbarClose<CR>
" PyDiction
let g:pydiction_location = '/home/tankywoo/.vim/bundle/Pydiction/complete-dict' " TODO
let g:pydiction_menu_height = 10
" NERDTree
nmap <leader>tne :NERDTree<CR>
nmap <leader>ttne :NERDTreeClose<CR>
" vim-powerline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors"
au BufRead,BufNewFile *.md set filetype=markdown  " .md default is modula2
" neocomplcache
"let g:neocomplcache_enable_at_startup = 1

" Better Rainbow Parentheses
"let g:rbpt_colorpairs = [
"    \ ['brown',       'RoyalBlue3'],
"    \ ['Darkblue',    'SeaGreen3'],
"    \ ['darkgray',    'DarkOrchid3'],
"    \ ['darkgreen',   'firebrick3'],
"    \ ['darkcyan',    'RoyalBlue3'],
"    \ ['darkred',     'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['brown',       'firebrick3'],
"    \ ['gray',        'RoyalBlue3'],
"    \ ['black',       'SeaGreen3'],
"    \ ['darkmagenta', 'DarkOrchid3'],
"    \ ['Darkblue',    'firebrick3'],
"    \ ['darkgreen',   'RoyalBlue3'],
"    \ ['darkcyan',    'SeaGreen3'],
"    \ ['darkred',     'DarkOrchid3'],
"    \ ['red',         'firebrick3'],
"    \ ]
"
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

" Flake8
"autocmd BufWritePost *.py call Flake8()
"let g:flake8_builtins="_,apply"

" pep8
"let g:pep8_map='<C-k>'

" davidhalter/jedi-vim
autocmd FileType python setlocal completeopt-=preview    " disable docstring
let g:jedi#completions_command = "<C-N>"

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
highlight myTodo cterm=bold term=bold ctermbg=blue ctermfg=black
match myTodo /TODO/
highlight myFixme cterm=bold term=bold ctermbg=red ctermfg=black
match myFixme /FIXME/
highlight myXxx cterm=bold term=bold ctermbg=blue ctermfg=black
match myXxx /\(XXX\|FIXME\)/
