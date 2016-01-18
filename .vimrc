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
set cursorcolumn " Highlighter the vertical line"
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

"======================"
" Vundle Configuration "
"======================"
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

" original repos on github
" newer powerline is https://github.com/powerline/powerline
Plugin 'Lokaltog/vim-powerline'
Plugin 'chriskempson/tomorrow-theme'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'nvie/vim-flake8'
Plugin 'davidhalter/jedi-vim'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'airblade/vim-gitgutter'
"Plugin 'ervandew/supertab'
" neocomplete need vim --with-lua
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'kevinw/pyflakes-vim'
" doc: https://github.com/vim-scripts/pydoc.vim
"Plugin 'fs111/pydoc.vim'
Plugin 'SirVer/ultisnips'
" with ultisnips, Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'mattn/emmet-vim'
" https://github.com/plasticboy/vim-markdown
"Plugin 'plasticboy/vim-markdown'  " must behind tabular
" https://github.com/flazz/vim-colorschemes
"Plugin 'flazz/vim-colorschemes'

" vim-scripts repos
" Tagbar is more powerful than 'taglist.vim'
Plugin 'Tagbar'
" `Auto-Pairs` is more useful than `AutoClose`
" TODO need to research
Plugin 'Auto-Pairs'
"Plugin 'pep8'
"Plugin 'TaskList.vim'
" `snipMate` will conflict with `PyDiction`, Google
"Plugin 'snipMate'
"Plugin 'Pydiction'
"Plugin 'Color-Scheme-Explorer'
"Plugin 'Jinja'

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
" :RainbowParenthesesToggle            " Toggle it on/off
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

" rainbow_parentheses.vim
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ]

" vim-gitgutter
" https://github.com/airblade/vim-gitgutter
let g:gitgutter_max_signs = 500
"let g:gitgutter_highlight_lines = 1

" SirVer/ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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

" vim-markdown
"let g:vim_markdown_frontmatter=1

let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/Users/TankyWoo/.dotfiles/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

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

" vim-gitgutter
highlight clear SignColumn
"highlight GitGutterAdd ctermfg=green guifg=darkgreen
"highlight GitGutterChange ctermfg=yellow guifg=darkyellow
"highlight GitGutterDelete ctermfg=red guifg=darkred
"highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow
"highlight GitGutterAddLine ctermbg=darkgreen guifg=darkgreen
