local telescope_builtin = require("telescope.builtin")
local gitsigns = require("gitsigns.actions")
local map = require("utils.mappings").map
local please = require("please")

vim.g.mapleader = " "

map("i", "jj", "<esc>")

map("i", "II", "<esc>I")
map("i", "AA", "<esc>A")

-- telescope.nvim
map("n", "<c-p>", telescope_builtin.find_files)
map("n", "<m-p>", function()
	telescope_builtin.find_files({ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })
end)
map("n", "<c-f>", telescope_builtin.live_grep)
map("n", "<m-f>", function()
	telescope_builtin.live_grep({ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] })
end)
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
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "<leader>ca", vim.lsp.buf.code_action)

-- vim-fugitive
map("n", "<leader>gb", "<cmd>:Git blame<cr>")

-- gitsigns.nvim
map("n", "]c", gitsigns.next_hunk)
map("n", "[c", gitsigns.prev_hunk)

-- please.nvim
vim.keymap.set("n", "<leader>pj", please.jump_to_target, { silent = true })
vim.keymap.set("n", "<leader>pb", please.build, { silent = true })
vim.keymap.set("n", "<leader>pt", please.test, { silent = true })
vim.keymap.set("n", "<leader>pct", function()
	require("please").test({ under_cursor = true })
end, { silent = true })
vim.keymap.set("n", "<leader>pr", please.run, { silent = true })
vim.keymap.set("n", "<leader>py", please.yank, { silent = true })

-- ReplaceWithRegister
vim.keymap.set("n", "<leader>r", "<Plug>ReplaceWithRegisterOperator")
vim.keymap.set("n", "<leader>rr", "<Plug>ReplaceWithRegisterLine")
vim.keymap.set("x", "<leader>r", "<Plug>ReplaceWithRegisterVisual")
