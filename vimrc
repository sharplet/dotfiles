" plugins
call pathogen#infect()
call pathogen#helptags()

" enable project-specific .vimrc files
set exrc

let mapleader=","

" syntax highlighting & line numbers
syntax on
set relativenumber

" color scheme
colorscheme twilight256

" invisibles
nmap <leader>l :set list!<CR>
set listchars=tab:‣\ ,eol:¬
set list

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" window management
nmap <leader>w :bd<CR>
nmap <leader><leader>w :%bd<CR>
nmap <leader>q :q<CR>
nmap <leader><leader>q :qa<CR>

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
set ignorecase

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
