" Set up the module for syntax highlighting with treesitter
lua <<EOF
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.python.used_by = 'please'
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  -- ignore_install = { "yaml" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"yaml" },  -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
  },
}
EOF

" Need to enable true colours for some colorschemes
" iTerm supports true colours, other emulators may not
set termguicolors
colorscheme nord
