local lualine = require("lualine")
local ts_utils = require("nvim-treesitter.ts_utils")
local query = require("vim.treesitter.query")

local value_types = { "string", "number", "true", "false", "null", "object", "array" }

local jsonpath = function()
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
	return path
end

lualine.setup({
	sections = {
		lualine_a = {
			{
				"filename",
				path = 1, -- relative file path
			},
		},
		lualine_c = { { jsonpath } },
	},
	options = {
		theme = "nord",
	},
})
