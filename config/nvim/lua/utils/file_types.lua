local M = {}

local augroup = vim.api.nvim_create_augroup("file_types", { clear = true })

local function add_tab_size_autocmd(file_type, tab_size)
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			vim.bo.tabstop = tab_size
			vim.bo.shiftwidth = tab_size
		end,
		pattern = file_type,
		group = augroup,
		desc = string.format("Use %d space tabs", tab_size),
	})
end

local function add_text_width_autocmd(file_type, text_width)
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			vim.bo.textwidth = text_width
			vim.wo.colorcolumn = tostring(text_width)
			vim.cmd("setlocal formatoptions-=o")
		end,
		pattern = file_type,
		group = augroup,
		desc = string.format("Use %d textwidth", text_width),
	})
end

local function add_indent_with_tabs_autocmd(file_type)
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			vim.bo.expandtab = false
		end,
		pattern = file_type,
		group = augroup,
		desc = "Indent with tabs",
	})
end

local function enable_spellcheck(file_type)
	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			vim.cmd("setlocal spell")
		end,
		pattern = file_type,
		group = augroup,
		desc = "Turn spellcheck on",
	})
end

M.auto_format_file_types = {}

M.setup = function(opts)
	M.auto_format_file_types = {}

	for file_type, settings in pairs(opts) do
		if settings.tab_size then
			add_tab_size_autocmd(file_type, settings.tab_size)
		end

		if settings.text_width then
			add_text_width_autocmd(file_type, settings.text_width)
		end

		if settings.indent_with_tabs then
			add_indent_with_tabs_autocmd(file_type)
		end

		if settings.format_on_save then
			M.auto_format_file_types[file_type] = true
		end
		if settings.spellcheck then
			enable_spellcheck(file_type)
		end
	end
end

return M
