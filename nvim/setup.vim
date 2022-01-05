" enable scrolling and selecting text with the mouse in 'a' (all) mode
" (may only work in iTerm)
set mouse=a
" set the width of a tab to 4 spaces
set tabstop=4
" set the width of an indent to 1 tab (e.g. 'how many tabs should I move when
" you do '<<' ?)"
set shiftwidth=4

" uses spaces for please build files
:autocmd BufNewFile,BufRead BUILD setlocal expandtab 

" Display absolute line numbers
set number

" copy yanked text to system clipboard (including over ssh)
autocmd TextYankPost * execute 'OSCYankReg "'
