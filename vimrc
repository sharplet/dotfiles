set nocompatible

set backspace=indent,eol,start
set linebreak
set mouse=a
set number
set wrap
syntax on

colorscheme twilight256

au BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown set linebreak
