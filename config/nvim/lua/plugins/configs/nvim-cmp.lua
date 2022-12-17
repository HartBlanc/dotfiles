local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		{ name = "nvim_lua" },
	}),
	completion = {
		completeopt = "menu,menuone,preview,noinsert",
	},
	confirmation = {
		default_behavior = cmp.ConfirmBehavior.Replace,
	},
	mapping = {
		["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- get autocompletion suggestions
		-- ["<c-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<c-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<c-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
		["<c-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),
		["<c-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. `select = true` implicity confirms the item when it is selected. To explicitly remove the item you must abort.
	},
})

-- Use the current buffer as the source when using `/` in the cmdline
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Use cmdline & path sources when using ':' in the cmdline
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})
