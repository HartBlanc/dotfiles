local fm_nvim = require("fm-nvim")

local function chg_cwd()
	pcall(function()
		local file = vim.fn.readfile("/tmp/vifm")[1]
		os.remove("/tmp/vifm")
		if vim.fn.isdirectory(file) == 1 then
			vim.cmd("lcd " .. file)
		end
	end)
end

local function mappings()
	-- write cwd to /tmp/vifm before exiting vifm so that it can be read by on_close
	vim.api.nvim_buf_set_keymap(0, "t", "<c-g>", ":execute ':!echo %d > /tmp/vifm'<cr>:q<cr>", { silent = true })
end

fm_nvim.setup({
	on_close = {
		chg_cwd,
	},
	on_open = {
		mappings,
	},
})
