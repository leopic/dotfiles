set number
set nowrap
set expandtab
set shiftwidth=2
set softtabstop=2
set syntax=html
set cursorline
set laststatus=2
syntax on
set wildmenu
set wildmode=list:longest
set title
let g:vundle_default_git_proto = 'git'

" Bundle starts here
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-haml'
Bundle 'ervandew/supertab'
" vim-scripts repos
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
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

