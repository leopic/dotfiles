" theme
colorscheme desert
" line numbers
set number
" don't wrap long lines
set nowrap
" file endings to unix
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
" title
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
" Vertical line after 80 chars
set colorcolumn=80

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

