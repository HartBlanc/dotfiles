local fm_nvim = require("fm-nvim")
local telescope_builtin = require("telescope.builtin")

local function chg_cwd()
	pcall(function()
		local file = vim.fn.readfile("/tmp/vifm-cd")[1]
		os.remove("/tmp/vifm-cd")
		if vim.fn.isdirectory(file) == 1 then
			vim.cmd("lcd " .. file)
		end
	end)
end

local function grep_in_dir()
	pcall(function()
		local file = vim.fn.readfile("/tmp/vifm-grep")[1]
		os.remove("/tmp/vifm-grep")
		if vim.fn.isdirectory(file) == 1 then
			telescope_builtin.live_grep({ cwd = file })
		end
	end)
end

local function files_in_dir()
	pcall(function()
		local file = vim.fn.readfile("/tmp/vifm-files")[1]
		os.remove("/tmp/vifm-files")
		if vim.fn.isdirectory(file) == 1 then
			telescope_builtin.find_files({ cwd = file })
		end
	end)
end

local function mappings()
	-- write cwd to /tmp/vifm before exiting vifm so that it can be read by on_close to change the directory
	vim.api.nvim_buf_set_keymap(0, "t", "<c-d>", ":execute ':!echo %d > /tmp/vifm-cd'<cr>:q<cr>", { silent = true })
	vim.api.nvim_buf_set_keymap(0, "t", "<c-g>", ":execute ':!echo %d > /tmp/vifm-grep'<cr>:q<cr>", { silent = true })
	vim.api.nvim_buf_set_keymap(0, "t", "<c-f>", ":execute ':!echo %d > /tmp/vifm-files'<cr>:q<cr>", { silent = true })

	-- make ctrl-v close the file manager and open the file in a split pane. The default behaviour is to only
	-- open the split pane once the file manager has been closed manually by the user.
	vim.api.nvim_buf_set_keymap(
		0,
		"t",
		"<c-v>",
		'<C-\\><C-n>:lua require("fm-nvim").setMethod("vsplit | edit")<CR>il<cr>',
		{ silent = true }
	)
end

fm_nvim.setup({
	on_close = {
		function()
			chg_cwd()
			grep_in_dir()
			files_in_dir()
		end,
	},
	on_open = {
		mappings,
	},
	mappings = {
		-- something that I'm unlikely to press so that it is effectively disabled (these mappings are set after on_open
		-- so it would override the <c-v> defined in mappings if we didn't set it)
		vert_split = "sirerofpuwyq-;ufwyq-;pufyqw-;pufyqw-;",
	},
	ui = {
		float = {
			border = "rounded",
		},
	},
})
