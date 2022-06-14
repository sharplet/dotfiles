set nocompatible

set backspace=indent,eol,start
set colorcolumn=80
set cursorline
set expandtab
set linebreak
set mouse=a
set number
set ts=2 sts=2 sw=2
set wrap
syntax on

colorscheme twilight256

au BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown set linebreak
