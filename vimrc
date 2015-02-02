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

" automatically load changes in disk if the buffer has not changed
set autoread

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" enable hidden buffers
set hidden

" put vim swap files into a shared directory rather than the standard '.%.swp'
" location alongside the file being edited
set dir=~/.vimswap

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file (restore to previous version)
  set backupdir=~/.vimbackup,.,~/tmp,~/
  set undofile          " keep an undo file (undo changes after closing)
  set undodir=~/.vimundo,.,~/tmp,~/
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set laststatus=2        " always show the status line
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set ignorecase          " case insensitive searching
set smartcase           " override ignorecase when pattern contains upper case characters
set expandtab           " use spaces instead of tabs by default
set sts=4 ts=4 sw=4     " default indentation
set conceallevel=0      " ensure vertical bars are visible in help

" invisibles
set list
set listchars+=tab:‣\ ,eol:¬

" Line wrapping
set nowrap              " disable line wrapping
set sidescroll=5        " minimal number of columns to scroll horizontally
set listchars+=precedes:←,extends:→ " visual indicator of long lines

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

if !has("gui_running")
  colorscheme twilight256
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

  " Set up text width and format options
  autocmd FileType text,markdown        setlocal autoindent
  autocmd FileType text,markdown        setlocal formatoptions+=2
  autocmd FileType text,markdown,c,cpp,objc,objcpp setlocal textwidth=78
  autocmd FileType c,cpp,objc,objcpp    setlocal formatoptions+=ro
  autocmd FileType c,cpp,objc,objcpp    setlocal comments=b:///,sr:/**,mb:*\ ,ex:*/,b://,sr:/*,mb:*,ex:*/

  " Set up some file types
  autocmd BufRead,BufNewFile *.m set filetype=objc
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

set number                      " line numbers
"set relativenumber              " relative line numbers


"" Mappings

let mapleader=","


"" Selection mode

" Evaluate a selection in-place using <C-R>=
snoremap <C-R><C-R> "-c<C-R>=<C-R>-<CR><Esc>


"" Normal mode

" Quickly close windows or buffers
nmap <leader>w :bd<CR>
nmap <leader><leader>w :%bd<CR>
nmap <leader>q :q<CR>
nmap <leader><leader>q :qa<CR>


"" Git

" switch to the git status buffer in the current window
nmap <leader>s :Gstatus<CR>:only<CR>


"" TextMate-style text bubbling

nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [e`[V`]
vmap <C-Down> ]e`[V`]


"" Completion

set wildmenu
set wildmode=longest,full


"" NERDCommenter

let g:NERDCustomDelimiters = {
  \ 'ruby': { 'left': '# ' }
\ }


"" Miscellaneous

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif
