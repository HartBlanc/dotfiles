local lspconfig = require("lspconfig")
local lspconfigs = require("lspconfig.configs")
local lsp_installer = require("nvim-lsp-installer")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Add configuration for the Please language server (it is not included in lspconfigs by default)
lspconfigs.please = {
	default_config = {
		cmd = { "plz", "tool", "lps" },
		filetypes = { "please" },
		root_dir = lspconfig.util.root_pattern(".plzconfig"),
	},
}

-- Add capabilities from completion engine
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Install language servers if not already installed
local servers = {
	"gopls",
	"pyright",
	"yamlls",
	"vimls",
	"bashls",
	"intelephense",
	"tsserver",
	"sumneko_lua",
	"please",
}

-- Define options and how to set up language server
local opts = {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

local function install_or_setup(install, name, server)
	if not install then
		lspconfig[name].setup(opts)
		return
	end

	if server:is_installed() then
		return
	end

	print("Installing " .. name)
	server:install()
end

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	install_or_setup(server_is_found, name, server)
end

lsp_installer.on_server_ready(function(server)
	server:setup(opts)
end)
