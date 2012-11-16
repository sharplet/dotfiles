" enable pathogen
call pathogen#infect()
call pathogen#helptags()

" disable some stuff I'm not using
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'nerdcommenter')

" basic settings
set nocompatible
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set showmatch
set vb t_vb=
set ruler
set nu
set showcmd
syntax on
set incsearch
filetype plugin indent on
set tw=72

" -----------------------------------------
"  http://stackoverflow.com/questions/2157914/can-vim-monitor-realtime-changes-to-a-file
"
"  automatically reload file when it changes on disk
set autoread
" -----------------------------------------
" http://mislav.uniqpath.com/2011/12/vim-revisited/
" 
" use comma as <Leader> key instead of backslash
let mapleader=","

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

" ,, will open last buffer
nnoremap <leader><leader> <c-^> 
" -----------------------------------------
" http://stackoverflow.com/questions/1919028/how-to-show-vertical-line-to-wrap-the-line-in-vim
set colorcolumn=+1        " highlight column after 'textwidth'
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
" -----------------------------------------

" spell checking
"setlocal spell spelllang=en_au

" environment variables
let $BIBINPUT="/Users/adsharp/.bibfiles/"
let $BIBINPUTS=$BIBINPUT
" let $PATH="~/bin:$PATH"

" abbreviations
iab lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

" latex stuff
au FileType tex set makeprg=latexmake

iab latextemplate \documentclass[a4paper,11pt]{article}%\usepackage{fontspec}\usepackage{xunicode}\usepackage{xltxtra}\begin{document}\end{document}<Up><Up>
iab itemize \begin{itemize}	\item <BS><BS>\end{itemize}<Up><End>
iab enumerate \begin{enumerate}	\item <BS>\end{enumerate}<Up><End>
iab description \begin{description}	\item <BS>\end{description}<Up><End>
iab em \emph{}<Left>
iab br \textbf{}<Left>
iab \i \item
iab sec \section{}<Left>
iab sub \subsection{}<Left>

nmap  ebi\textbf{<Esc>ea}<Esc>
nmap  ebi\emph{<Esc>ea}<Esc>
