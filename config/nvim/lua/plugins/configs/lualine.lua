local lualine = require("lualine")
local ts_utils = require("nvim-treesitter.ts_utils")
local query = require("vim.treesitter.query")

local pathfunction = function(array_node_type)
	local current_node = ts_utils.get_node_at_cursor()
	local path = ""
	while current_node do
		if current_node:type():sub(-#"pair") == "pair" then
			local key_node = current_node:field("key")[1]:named_child(0)
			local key = query.get_node_text(key_node, 0)
			path = string.format(".%s%s", key, path)
		elseif current_node:parent() and current_node:parent():type():sub(-#array_node_type) == array_node_type then
			local count = 0
			local previous_sibling = ts_utils.get_previous_node(current_node)
			while previous_sibling do
				count = count + 1
				previous_sibling = ts_utils.get_previous_node(previous_sibling)
			end
			path = string.format("[%d]%s", count, path)
		end
		current_node = current_node:parent()
	end
	return path
end

local lualine_path = function()
	if vim.bo.filetype == "json" then
		return pathfunction("array")
	elseif vim.bo.filetype == "yaml" then
		return pathfunction("sequence")
	end
	return ""
end

lualine.setup({
	sections = {
		lualine_a = {
			{
				"filename",
				path = 1, -- relative file path
			},
		},
		lualine_c = { { lualine_path } },
	},
	options = {
		theme = "nord",
	},
})
