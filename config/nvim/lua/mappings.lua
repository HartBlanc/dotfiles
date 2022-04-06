local telescope = require('telescope.builtin')
local gitsigns = require('gitsigns.actions')
local map = require('utils.mappings').map
local please = require('please')

map('i', 'jj', '<esc>')

map('i', 'II', '<esc>I')
map('i', 'AA', '<esc>A')

-- telescope.nvim
map('n', '<c-p>', telescope.find_files)
map('n', '<m-p>', function()
    telescope.find_files({ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })
end)
map('n', '<c-f>', telescope.live_grep)
map('n', '<m-f>', function()
    telescope.live_grep({ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]})
end)
map('n', 'ff', telescope.current_buffer_fuzzy_find)
map('n', 'fb', telescope.buffers)
map('n', 'fo', telescope.oldfiles)
map('n', 'fr', telescope.resume)
map('n', 'fs', telescope.lsp_document_symbols)
map('n', 'gd', function()
    telescope.lsp_definitions({ jump_type = 'never' })
end)
map('n', 'gr', function()
    telescope.lsp_references({ jump_type = 'never' })
end)
map('n', 'gi', function()
    telescope.lsp_implementations({ jump_type = 'never' })
end)

-- lsp
map('n', 'K', vim.lsp.buf.hover)
map('n', '<leader>rn', vim.lsp.buf.rename)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', '<leader>ca', vim.lsp.buf.code_action)

-- vim-fugitive
map('n', '<leader>gb', '<cmd>:Git blame<cr>')

-- gitsigns.nvim
map('n', ']c', gitsigns.next_hunk)
map('n', '[c', gitsigns.prev_hunk)

-- please.nvim
map('n', '<leader>pj', please.jump_to_target)
