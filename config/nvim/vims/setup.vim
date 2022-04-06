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
autocmd Filetype markdown,proto setlocal spell spelllang=en_gb spellcapcheck=

nnoremap <leader>pj <cmd>Please jump_to_target<cr>
command Bd bp\|bd \#

" autofmt file on save
augroup fmt
  autocmd!
  au BufWritePre *.go try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END

" Display absolute line numbers
set number

" copy yanked text to system clipboard (including over ssh)
autocmd TextYankPost * execute 'OSCYankReg "'

" lua <<EOF

" vim.keymap.set('n', '<leader>gc', function()
"   local cwd = vim.fn.getcwd()
"   local git_root = vim.trim(vim.fn.system 'git rev-parse --show-toplevel')

"   local diff_lines = vim.fn.systemlist 'git diff -U0 --no-prefix'
"   local added_files = vim.fn.systemlist(string.format('git ls-files --others --exclude-standard %s', git_root))

"   local qf_items = {}

"   local current_filename
"   for _, line in pairs(diff_lines) do
"     -- diff --git lua/please.lua lua/please.lua
"     local filename = line:match '^diff %-%-git .+ (.+)'
"     if filename then
"       local absolute_filepath = git_root .. '/' .. filename
"       local relative_filepath = vim.trim(
"         vim.fn.system(string.format('realpath --relative-to %s %s', cwd, absolute_filepath))
"       )
"       current_filename = relative_filepath
"     end
"     -- @@ -4 +4,3 @@ M.test = function()
"     local line_number = line:match '^@@ %-.+ %+(%d+)'
"     if line_number then
"       table.insert(qf_items, {
"         filename = current_filename,
"         text = 'changed',
"         lnum = tonumber(line_number),
"       })
"     end
"   end
"   for _, filename in pairs(added_files) do
"     table.insert(qf_items, { filename = filename, lnum = 1, text = 'added' })
"   end

"   vim.fn.setqflist(qf_items)
"   if #qf_items == 0 then
"     print 'no changed / added files'
"     vim.cmd 'cclose'
"     return
"   end
"   vim.cmd 'copen'
"   vim.cmd 'cfirst'
" end)
" EOF
