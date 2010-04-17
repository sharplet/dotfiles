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

" spell checking
setlocal spell spelllang=en_au

" environment variables
let $BIBINPUT="/Users/adsharp/.bibfiles/"
let $BIBINPUTS=$BIBINPUT

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
