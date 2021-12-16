" Remap ctrl-p to search for files by filepath in telescope
nnoremap <silent> <C-p> :Telescope find_files<CR>
" Remap ctrl-f to grep line contents in files using telescope
nnoremap <silent> <C-f> :Telescope live_grep<CR>
" Remap fb to open a list of the currently open buffers
nnoremap <silent> fb :Telescope buffers<CR>

" Remap ctrl-d to delete a buffer in the buffers window
lua <<EOF
local actions = require "telescope.actions"
require("telescope").setup {
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
	  ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        },
        n = {
	  ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  }
}
require('telescope').load_extension('fzf')
EOF


" set up status line
lua require'lualine'.setup()

