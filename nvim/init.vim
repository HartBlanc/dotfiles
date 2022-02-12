" source all of the vim files
let g:nvim_config_root = stdpath('config')
let g:config_file_list = ['setup.vim',
    \ 'plugins.vim',
    \ 'cmp.vim',
	\ 'lsp.vim',
    \ 'colours.vim',
    \ 'ui.vim',
    \ ]

for f in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . f
endfor

" enable inline git blame annotation
let g:blamer_enabled = 1

" enable gg and G experimental smooth scrolling
let g:smoothie_experimental_mappings = 1
