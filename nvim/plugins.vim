" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" Declare the list of plugins.

" Configurations for neovims built in LSP client
Plug 'neovim/nvim-lspconfig'

" Telescope Code/File searching
" plenary is a dependency of telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" a faster C-based backend with fuzzyfinding 
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Treesitter is included for syntax highlighting
" TSUpdate updates the treesitter parsers on update
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

" Fugitive git plugin - has a nice :Git blame command
Plug 'tpope/vim-fugitive'

" nightfly 'true colour', treesitter compatible, color scheme
Plug 'bluz71/vim-nightfly-guicolors'

" coq autocompletion
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" inline git blame
Plug 'APZelos/blamer.nvim'

" navigate between tmux and vim using a consistent set of hotkeys 
Plug 'christoomey/vim-tmux-navigator'

" a status line plugin
Plug 'nvim-lualine/lualine.nvim'

" smoother scrolling for navigation commands (e.g. C-d C-u)
Plug 'psliwka/vim-smoothie'

" yank to clipboard (incl. over ssh)
Plug 'ojroques/vim-oscyank'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
