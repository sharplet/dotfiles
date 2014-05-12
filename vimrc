" plugins
call pathogen#infect()
call pathogen#helptags()

" enable project-specific .vimrc files
set exrc

let mapleader=","

" syntax highlighting & line numbers
syntax on
set nu
set relativenumber

" color scheme
colorscheme twilight256

" invisibles
nmap <leader>l :set list!<CR>
set listchars=tab:‣\ ,eol:¬
set list

" filetype
filetype plugin on
filetype indent on
autocmd BufRead,BufNewFile Podfile,*.podspec,Gemfile set filetype=ruby

" text formatting
set expandtab
set tw=72
set ts=4
set sw=4

" search
set incsearch

" completion
set wildmenu
set wildmode=longest,full

" ignore in command-t
set wildignore=**/*.png,Build/**

" stop unsafe commands running in a .vimrc (http://blog.stwrt.ca/2013/01/23/project-specific-vimrc)
set secure

" NERDTree
"autocmd vimenter * NERDTree

" NERDCommenter
let g:NERDCustomDelimiters = {
  \ 'ruby': { 'left': '# ' }
\ }
