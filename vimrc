" compile, execute after save 
" autocmd BufWritePost * !~/compile.sh <afile>

colorscheme desert
" line numbers
set number
" don't wrap long lines
set nowrap
set expandtab
set shiftwidth=2
set softtabstop=2
set syntax=html
" line under the cursorline
set cursorline
" highlighting current column
set cursorcolumn
" two lines in status bar
set laststatus=2
" turning on syntax highlighting
syntax on
" running wild brother
set wildmenu
set wildmode=list:longest
set title
" backspace broke wtf!
set bs=2
" search as you type
set incsearch
" search highlight
set hlsearch
" code folding
set foldmethod=manual
" Explicitly tell vim that the terminal supports 256 colors
set t_Co=256
" sometimes vundle can't resolve https protocol
let g:vundle_default_git_proto = 'git'
" intentos de mapping
map <F2> :FufFile 
" http://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

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
" git wrapper
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-haml' 
" autocomplete con tab
Bundle 'ervandew/supertab'
" super tab!
Bundle 'Lokaltog/vim-powerline'
" zencoding
Bundle 'mattn/zencoding-vim'
" autoclose {}'s
Bundle 'Townk/vim-autoclose' 
Bundle 'mattn/webapi-vim'
" :Gist, fawesome
Bundle 'mattn/gist-vim'
" syntax highlight for stylus
Bundle 'wavded/vim-stylus'
" add C++ support
Bundle 'Rip-Rip/clang_complete'
" CSSComb plugin
Bundle 'miripiruni/CSScomb-for-Vim'

" vim-scripts repos

Bundle 'L9'
" kick-ass kinder
Bundle 'FuzzyFinder'

" restore folds
Bundle 'restore_view.vim'

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

