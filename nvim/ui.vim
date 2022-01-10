" Remap ctrl-p to search for files by filepath
nnoremap <silent> <C-p> :Telescope find_files<CR>
" Remap ctrl-f to fzf all lines in cwd
nnoremap <silent> <C-f> :Telescope live_grep<CR>
" Remap ff to fzf lines in the currently open buffer
nnoremap <silent> ff :Telescope current_buffer_fuzzy_find<CR>
" Remap fb to open a list of the currently open buffers
nnoremap <silent> fb :Telescope buffers<CR>
" Remap fo to open a list of previously opened files
nnoremap <silent> fo :Telescope oldfiles<CR>

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
require("telescope").load_extension("file_browser")
require('telescope').load_extension('fzf')

-- remapping here ensures that we use the extension file_browser rather than the default one 
vim.api.nvim_set_keymap(
  "n",
  "fe",
  "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
  {noremap = true}
)
EOF


" block for lightspeed configuration
lua <<EOF
-- Note: This is just illustration - there is no need to copy/paste the
-- defaults, or call `setup` at all, if you do not want to change anything.
require'lightspeed'.setup {
  ignore_case = true,
}
EOF


" block for treesitter text objects
lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer", -- go to start of next function
        ["]]"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
    },
  },
}
EOF

" set up status line
lua require'lualine'.setup()

