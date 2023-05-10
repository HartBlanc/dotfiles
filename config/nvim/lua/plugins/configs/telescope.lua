local telescope_actions = require("telescope.actions")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local transform_mod = require("telescope.actions.mt").transform_mod
local state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

local custom_actions = transform_mod({
	open_first_qf_item = function(_)
		vim.cmd.cfirst()
	end,
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

--- Shortens the given path by either:
--- - making it relative if it's part of the cwd
--- - replacing the home directory with ~ if not
---@param path string
---@return string
local function shorten_path(path)
	local cwd = vim.fn.getcwd()
	if path == cwd then
		return ""
	end
	-- need to escape - since its a special character in lua patterns
	cwd = cwd:gsub("%-", "%%-")
	local relative_path, replacements = path:gsub("^" .. cwd .. "/", "")
	if replacements == 1 then
		return relative_path
	end
	local path_without_home = path:gsub("^" .. os.getenv("HOME"), "~")
	return path_without_home
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<ScrollWheelUp>"] = telescope_actions.preview_scrolling_up,
				["<ScrollWheelDown>"] = telescope_actions.preview_scrolling_down,
				["<c-q>"] = telescope_actions.smart_send_to_qflist
					+ telescope_actions.open_qflist
					+ custom_actions.open_first_qf_item,
			},
			n = {
				["<ScrollWheelUp>"] = telescope_actions.preview_scrolling_up,
				["<ScrollWheelDown>"] = telescope_actions.preview_scrolling_down,
				["<c-q>"] = telescope_actions.smart_send_to_qflist
					+ telescope_actions.open_qflist
					+ custom_actions.open_first_qf_item,
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
		lsp_document_symbols = {
			entry_maker = function(entry)
				local displayer = entry_display.create({
					separator = " ",
					items = {
						{ width = 13 }, -- symbol type
						{ remaining = true }, -- symbol name
					},
				})

				local make_display = function(entry)
					return displayer({
						{ entry.symbol_type, "CmpItemKind" .. entry.symbol_type },
						entry.symbol_name,
					})
				end

				return {
					valid = true,
					value = entry,
					ordinal = entry.text,
					display = make_display,
					filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr),
					lnum = entry.lnum,
					col = entry.col,
					symbol_name = entry.text:match("%[.+%]%s+(.*)"),
					symbol_type = entry.kind,
					start = entry.start,
					finish = entry.finish,
				}
			end,
		},
		-- lsp_references = {
		-- 	entry_maker = function(entry)
		-- 		local displayer = entry_display.create({
		-- 			separator = " ",
		-- 			items = {
		-- 				{ remaining = true }, -- filename
		-- 				{ remaining = true }, -- line:col
		-- 				{ remaining = true }, -- directory
		-- 			},
		-- 		})
		--
		-- 		local make_display = function(entry)
		-- 			return displayer({
		-- 				vim.fs.basename(entry.filename),
		-- 				{ entry.lnum .. ":" .. entry.col, "TelescopeResultsLineNr" },
		-- 				{ shorten_path(vim.fs.dirname(entry.filename)), "TelescopeResultsLineNr" },
		-- 			})
		-- 		end
		--
		-- 		return {
		-- 			valid = true,
		-- 			value = entry,
		-- 			ordinal = entry.filename .. entry.text,
		-- 			display = make_display,
		-- 			bufnr = entry.bufnr,
		-- 			filename = entry.filename,
		-- 			lnum = entry.lnum,
		-- 			col = entry.col,
		-- 			text = entry.text,
		-- 			start = entry.start,
		-- 			finish = entry.finish,
		-- 		}
		-- 	end,
		-- },
	},
})

telescope.load_extension("fzf")
