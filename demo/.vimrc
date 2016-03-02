" Necesary  for lots of cool vim things
set nocompatible
set encoding=utf-8

set clipboard=unnamed
set hid
set mouse=a
set cmdheight=2
set ttimeoutlen=100

if &term =~ '256color'
    set t_ut=
endif

set background=dark
set t_Co=256
color molokai
let g:rehash256 = 1

filetype off

let mapleader = ","

" Show partial commands in the last line of the screen
set showcmd

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Line Numbers PWN!
set number

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Keep 3 lines when scrolling
set scrolloff=3

" Syntax highlighting - not with default Tiny VIM in Ubuntu...
syntax on

" Show matching brackets
set showmatch

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Highlight search
set hlsearch

set encoding=utf-8

set hidden
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

set cursorline

" It happens so oftern that I type :Q instead of :q that it makes sense to make :Q just working. :Q is not used
" anyway by vim.
command Q q

" unindent with Shift-Tab
imap <S-Tab> <C-o><<

set nobackup
set noswapfile

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>:w

set nostartofline
" Remap VIM 0 to first non-blank character
map 0 ^

"nmap <F2> :tabnew<CR>
nmap <F3> :bprevious<CR>
nmap <F4> :bnext<CR>
