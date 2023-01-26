local telescope_builtin = require("telescope.builtin")
local gitsigns = require("gitsigns.actions")
local map = require("utils.mappings").map
local please = require("please")
local please_popup_runner = require("please.runners.popup")
local neoformat = require("plugins.configs.neoformat")

vim.g.mapleader = " "

map("i", "jj", "<esc>")

map("i", "II", "<esc>I")
map("i", "AA", "<esc>A")

map("n", "<leader>tl", function()
	vim.o.relativenumber = not vim.o.relativenumber
end)

-- telescope.nvim
map("n", "<c-f>", telescope_builtin.find_files)
map("n", "<c-g>", telescope_builtin.live_grep)
map("n", "ff", telescope_builtin.current_buffer_fuzzy_find)
map("n", "fb", telescope_builtin.buffers)
map("n", "fo", telescope_builtin.oldfiles)
map("n", "fr", telescope_builtin.resume)
map("n", "fs", telescope_builtin.lsp_document_symbols)
map("n", "gd", function()
	telescope_builtin.lsp_definitions({ jump_type = "never" })
end)
map("n", "gr", function()
	telescope_builtin.lsp_references({ jump_type = "never" })
end)
map("n", "gt", function()
	telescope_builtin.lsp_type_definitions({ jump_type = "never" })
end)
map("n", "gi", function()
	telescope_builtin.lsp_implementations({ jump_type = "never" })
end)
map("n", "fd", function()
	local dirs = vim.fn.systemlist("fd -H --type d . ~")
	vim.ui.select(dirs, { prompt = "Select directory to grep in" }, function(selection)
		telescope_builtin.live_grep({ cwd = selection })
	end)
end)

-- lsp
map("n", "E", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "<leader>ca", vim.lsp.buf.code_action)

-- vim-fugitive
map("n", "<leader>gb", "<cmd>:Git blame<cr>")

-- gitsigns.nvim
map("n", "]c", gitsigns.next_hunk)
map("n", "[c", gitsigns.prev_hunk)
map("n", "<leader>gc", function()
	vim.fn.system("git diff --quiet")
	if vim.v.shell_error == 0 then
		print("No Git changes")
		vim.cmd("cclose")
		return
	end

	vim.fn.setqflist({})
	gitsigns.setqflist("all", { open = false })
	-- wait for quickfix list to have items in before opening
	vim.wait(5000, function()
		local qf_items = vim.fn.getqflist()
		return #qf_items > 0
	end)
	vim.cmd("copen")
	vim.cmd("cfirst")
end)

-- please.nvim
map("n", "<leader>pj", please.jump_to_target, { silent = true })
map("n", "<leader>pb", please.build, { silent = true })
map("n", "<leader>pt", please.test, { silent = true })
map("n", "<leader>pct", function()
	require("please").test({ under_cursor = true })
end, { silent = true })
map("n", "<leader>plt", function()
	require("please").test({ list = true })
end)
map("n", "<leader>pr", please.run, { silent = true })
map("n", "<leader>py", please.yank, { silent = true })
map("n", "<leader>pp", please_popup_runner.restore)

-- ReplaceWithRegister
map("n", "<leader>r", "<Plug>ReplaceWithRegisterOperator")
map("n", "<leader>rr", "<Plug>ReplaceWithRegisterLine")
map("x", "<leader>r", "<Plug>ReplaceWithRegisterVisual")

map("n", "<leader>Y", function()
	vim.cmd("let @\" = expand('%:p')")
	vim.cmd('let @* = @"')
	vim.cmd('OSCYankReg "')
end)

-- Vifm
map("n", "<leader>n", ":Vifm %:p:h<cr>")

-- '/' text objects
map("o", "i/", ":<C-U>normal! T/vt/<CR>")
map("o", "a/", ":<C-U>normal! F/vt/<CR>")
map("v", "i/", ":<C-U>normal! T/vt/<CR>")
map("v", "a/", ":<C-U>normal! F/vt/<CR>")

-- neoformat
map("n", "<leader>fm", "<cmd>Neoformat<cr>")
map("n", "<leader>ft", neoformat.toggle_auto_neoformatting)

-- colemak
map({ "n", "v" }, "n", "j")
map({ "n", "v" }, "e", "k")
map({ "n", "v" }, "i", "l")

map({ "n", "v" }, "j", "e")
map({ "n", "v" }, "k", "n")
map({ "n", "v" }, "K", "N")
map({ "n", "v" }, "l", "i")

local colemak = true

map("n", "<leader>c", function()
	if colemak then
		vim.keymap.del({ "n", "v" }, "n")
		vim.keymap.del({ "n", "v" }, "e")
		vim.keymap.del({ "n", "v" }, "i")

		vim.keymap.del({ "n", "v" }, "j")
		vim.keymap.del({ "n", "v" }, "k")
		vim.keymap.del({ "n", "v" }, "K")
		vim.keymap.del({ "n", "v" }, "l")

		colemak = false
	else
		map({ "n", "v" }, "n", "j")
		map({ "n", "v" }, "e", "k")
		map({ "n", "v" }, "i", "l")

		map({ "n", "v" }, "j", "e")
		map({ "n", "v" }, "k", "n")
		map({ "n", "v" }, "K", "N")
		map({ "n", "v" }, "l", "i")

		colemak = true
	end
end)

map("n", "<leader>ut", "<cmd>:UndotreeToggle<cr>")
