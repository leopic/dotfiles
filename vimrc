set number
set nowrap
set expandtab
set shiftwidth=2
set softtabstop=2
set syntax=html
set cursorline
set cursorcolumn
set laststatus=2
syntax on
set wildmenu
set wildmode=list:longest
set title
set incsearch " search as you type
set hlsearch " search highlight
set foldmethod=manual " code folding
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
let g:vundle_default_git_proto = 'git'

" use Zencoding for other languages, not just .html files.
let g:user_zen_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'jsp' : {
  \    'extends' : 'html',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \}

" Bundle starts here
set nocompatible               " be iMproved
filetype off                   " required!

" Vundle required stuff, don't mess with
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-haml' 
Bundle 'ervandew/supertab'
Bundle 'Lokaltog/vim-powerline'
Bundle 'mattn/zencoding-vim'
Bundle 'Townk/vim-autoclose' 

" vim-scripts repos
Bundle 'restore_view.vim'
" por alguna razon esto se cae en CENTos
if $HOSTNAME != "lpicado-atg-dev.bcinfra.net"
  Bundle 'L9'
  Bundle 'FuzzyFinder'
endif

" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
"
" see :h vundle for more details or wiki for FAQ

