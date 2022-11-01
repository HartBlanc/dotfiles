local lspconfig = require("lspconfig")
local lspconfigs = require("lspconfig.configs")
local util = require("lspconfig.util")
local lsp_installer = require("nvim-lsp-installer")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local neodev = require("neodev")

neodev.setup({})
lsp_installer.setup({})

-- Add configuration for the Please language server (it is not included in lspconfigs by default)
lspconfigs.please = {
	default_config = {
		cmd = { "plz", "tool", "lps" },
		filetypes = { "please" },
		root_dir = lspconfig.util.root_pattern(".plzconfig"),
	},
}

-- Add capabilities from completion engine
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- -- Install language servers if not already installed
-- local servers = {
-- 	"gopls",
-- 	"pyright",
-- 	"yamlls",
-- 	"vimls",
-- 	"bashls",
-- 	"intelephense",
-- 	"tsserver",
-- 	"sumneko_lua",
-- 	"please",
-- }

local servers = {
	gopls = {
		settings = {
			gopls = {
				directoryFilters = { "-plz-out" },
				linksInHover = false,
			},
		},
		root_dir = function(fname)
			local go_mod_root = util.root_pattern("go.mod")(fname)
			if go_mod_root then
				return go_mod_root
			end
			local plz_root = util.root_pattern(".plzconfig")(fname)
			local gopath_root = util.root_pattern("src")(fname)
			if plz_root and gopath_root then
				vim.env.GOPATH = string.format("%s:%s/plz-out/go", gopath_root, plz_root)
				vim.env.GO111MODULE = "off"
			end
			return vim.fn.getcwd()
		end,
	},
	pyright = {
		root_dir = function()
			return vim.fn.getcwd()
		end,
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					typeCheckingMode = "off",
					extraPaths = {
						"/home/callum/core3/src",
						"/home/callum/core3/src/plz-out/gen",
					},
				},
			},
		},
	},
	sumneko_lua = {},
	yamlls = {},
	vimls = {},
	please = {},
	bashls = {},
	intelephense = {},
}

for server, config in pairs(servers) do
	lspconfig[server].setup({
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
		settings = config.settings,
		root_dir = config.root_dir,
		cmd = config.cmd,
	})
end
