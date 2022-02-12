" enable scrolling and selecting text with the mouse in 'a' (all) mode
" (may only work in iTerm)
set mouse=a
" set the width of a tab to 4 spaces
set tabstop=4
" set the width of an indent to 1 tab (e.g. 'how many tabs should I move when
" you do '<<' ?)"
set shiftwidth=4
" expand tabs to spaces
set expandtab

" uses spaces for please build files
autocmd BufRead,BufNewFile BUILD,*.build_defs,*.build_def,*.build,*.plz set filetype=please
autocmd Filetype go setlocal expandtab!
autocmd Filetype markdown,proto setlocal spell spelllange=en_gb spellcapcheck=

" autofmt file on save
augroup fmt
  autocmd!
  au BufWritePre *.go try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790 | finally | silent Neoformat | endtry
augroup END

" Display absolute line numbers
set number

" copy yanked text to system clipboard (including over ssh)
autocmd TextYankPost * execute 'OSCYankReg "'
