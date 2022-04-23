require("nvim-treesitter.parsers").filetype_to_parsername.please = "python"

require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
    ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
				["ic"] = "@call.inner",
				["ac"] = "@call.outer",
				["iC"] = "@class.inner",
				["aC"] = "@class.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]a"] = "@parameter.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]A"] = "@parameter.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[a"] = "@parameter.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[A"] = "@parameter.outer",
			},
		},
	},
})

require("treesitter-context").setup()
