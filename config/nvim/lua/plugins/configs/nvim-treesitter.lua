require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = false,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["ic"] = "@call.inner",
				["ac"] = "@call.outer",
				["iC"] = "@class.inner",
				["aC"] = "@class.outer",
				["iv"] = "@literal_value.inner",
				["av"] = "@literal_value.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]a"] = "@parameter.inner",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[a"] = "@parameter.inner",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
			},
		},
	},
})

require("treesitter-context").setup()
