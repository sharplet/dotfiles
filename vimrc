" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Inject pathogen
call pathogen#infect()
call pathogen#helptags()

" Enable project-specific .vimrc files
set exrc

" stop unsafe commands running in a .vimrc (http://blog.stwrt.ca/2013/01/23/project-specific-vimrc)
set secure

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file (restore to previous version)
  set undofile          " keep an undo file (undo changes after closing)
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set laststatus=2        " always show the status line
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set ignorecase          " case insensitive searching
set smartcase           " override ignorecase when pattern contains upper case characters
set conceallevel=0      " ensure vertical bars are visible in help

" Use an interesting status line, including shortened filenames (like in tabs)
set statusline=%{pathshorten(fnamemodify(expand('%f'),':~:.'))}[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  "set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Set up some Ruby file types
  autocmd BufRead,BufNewFile Podfile,*.podspec,Gemfile set filetype=ruby

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

  set expandtab                 " always set expandtab on

endif " has("autocmd")

" Relative line numbers
set relativenumber

" invisibles
nmap <leader>l :set list!<CR>
set listchars=tab:‣\ ,eol:¬
set list

" Set up mappings
let mapleader=","

" window management
nmap <leader>w :bd<CR>
nmap <leader><leader>w :%bd<CR>
nmap <leader>q :q<CR>
nmap <leader><leader>q :qa<CR>

" Completion
set wildmenu
set wildmode=longest,full

" Color scheme
colorscheme twilight256

" NERDCommenter
let g:NERDCustomDelimiters = {
  \ 'ruby': { 'left': '# ' }
\ }

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif
