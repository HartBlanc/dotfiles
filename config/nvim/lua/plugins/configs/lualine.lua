local lualine = require("lualine")

lualine.setup({
	sections = {
		lualine_a = {
			{
				"filename",
				path = 1, -- relative file path
			},
		},
	},
	options = {
		theme = "nord",
	},
})
