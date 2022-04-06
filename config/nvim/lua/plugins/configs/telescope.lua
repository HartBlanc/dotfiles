local telescope_actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup({
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = 'dropdown',
            previewer = false,
            mappings = {
                i = {
                    ['<c-d>'] = telescope_actions.delete_buffer + telescope_actions.move_to_top,
                },
                n = {
	                ['<c-d>'] = telescope_actions.delete_buffer + telescope_actions.move_to_top,
                }
            }
        }
    }
})

telescope.load_extension('fzf')
