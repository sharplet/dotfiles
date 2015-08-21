" Configure font
set guifont=Inconsolata-dz:h11

" Use twilight colorscheme
set background=dark
colorscheme twilight-gui

" Only use block cursor, no blinking
set guicursor=n-v-c-i:block-Cursor/lCursor-blinkon0,o:hor50-Cursor

" A more useful window title
set titlestring=%t%(\ %M%)%(\ (%{fnamemodify(expand(\"%:p:h\"),':~:.')})%)%(\ %a%)\ -\ %{v:servername}
