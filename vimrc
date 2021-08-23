set nocompatible

set backspace=indent,eol,start
set number
syntax on

au BufRead,BufNewFile *.md set filetype=markdown
au FileType markdown set linebreak
