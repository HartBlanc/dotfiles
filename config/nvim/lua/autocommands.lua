local Job = require("plenary.job")

local group = vim.api.nvim_create_augroup("misc", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local file_extension = vim.fn.expand("%:e")
		if file_extension ~= "diff" then
			vim.cmd("%s/\\s\\+$//e")
		end
	end,
	group = group,
	desc = "Trim trailing whitespace",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.cmd("let @* = @_")
	end,
	group = vim.api.nvim_create_augroup("clipboard", { clear = true }),
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		local job = Job:new({
			command = "wollemi",
			args = { "gofmt", "." },
			-- run in the directory of the saved file since wollemi won't run outside of a plz repo
			cwd = vim.fn.expand("%:p:h"),
			env = {
				-- wollemi needs GOROOT to be set
				GOROOT = vim.trim(vim.fn.system("go env GOROOT")),
				PATH = vim.fn.getenv("PATH"),
			},
		})
		job:start()
	end,
	pattern = { "*.go" },
	group = group,
	desc = "Run wollemi on parent directory of go files on save",
})
