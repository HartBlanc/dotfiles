local telescope_actions = require("telescope.actions")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local transform_mod = require("telescope.actions.mt").transform_mod
local state = require("telescope.actions.state")

local custom_actions = transform_mod({
	grep_in_files = function(prompt_bufnr)
		local picker = state.get_current_picker(prompt_bufnr)
		local selections = picker:get_multi_selection()
		local filenames = {}
		if #selections > 0 then
			for _, entry in pairs(selections) do
				table.insert(filenames, entry[1])
			end
		else
			for entry in picker.manager:iter() do
				table.insert(filenames, entry[1])
			end
		end
		telescope_actions.close(prompt_bufnr)
		-- There's some race condition occurring when you instantly open another telescope finder, causing the initial mode
		-- to be normal and not insert. Adding this tiny delay seems to fix it.
		vim.defer_fn(function()
			telescope_builtin.live_grep({ search_dirs = filenames })
		end, 10)
	end,
})

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["<ScrollWheelUp>"] = telescope_actions.preview_scrolling_up,
				["<ScrollWheelDown>"] = telescope_actions.preview_scrolling_down,
			},
			i = {
				["<ScrollWheelUp>"] = telescope_actions.preview_scrolling_up,
				["<ScrollWheelDown>"] = telescope_actions.preview_scrolling_down,
			},
		},
	},
	pickers = {
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<c-d>"] = telescope_actions.delete_buffer + telescope_actions.move_to_top,
				},
				n = {
					["<c-d>"] = telescope_actions.delete_buffer + telescope_actions.move_to_top,
				},
			},
		},
		find_files = {
			mappings = {
				i = {
					["<c-f>"] = custom_actions.grep_in_files,
				},
				n = {
					["<c-f>"] = custom_actions.grep_in_files,
				},
			},
		},
	},
})

telescope.load_extension("fzf")
