local ts_utils = require("nvim-treesitter.ts_utils")
local query = require("vim.treesitter.query")

local value_types = { "string", "number", "true", "false", "null", "object", "array" }

vim.api.nvim_create_user_command("JSONPath", function()
	local current_node = ts_utils.get_node_at_cursor()
	local path = ""
	local last_value
	while current_node do
		if current_node:type() == "pair" then
			local key_node = current_node:field("key")[1]:named_child(0)
			local key = query.get_node_text(key_node, 0)
			path = string.format(".%s%s", key, path)
		elseif vim.tbl_contains(value_types, current_node:type()) then
			if current_node:type() == "array" and last_value then
				local idx = 0
				for child in current_node:iter_children() do
					if child:named() then
						if child:id() == last_value:id() then
							break
						else
							idx = idx + 1
						end
					end
				end
				path = string.format("[%d]%s", idx, path)
			end
			last_value = current_node
		end
		current_node = current_node:parent()
	end
	print(path)
end, {})

require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "tsn",
			scope_incremental = "n",
			scope_decremental = "N",
		},
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
