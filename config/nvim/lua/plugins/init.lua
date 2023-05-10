-- install packer and all of the packages if packer has not been installed already
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	_Packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local plugins = {
	"wbthomason/packer.nvim",
	"tpope/vim-eunuch",
	"tpope/vim-repeat",
	"tpope/vim-fugitive",
	"tpope/vim-unimpaired",
	"nvim-treesitter/playground",
	"lambdalisue/suda.vim",
	"vim-scripts/ReplaceWithRegister",
	"svban/YankAssassin.vim",
	"michaeljsmith/vim-indent-object",
	"mbbill/undotree",
	"https://gitlab.com/yorickpeterse/nvim-pqf.git",
	{
		"chaoren/vim-wordmotion",
		config = function()
			require("plugins.configs.vim-wordmotion")
		end,
	},
	{
		"tpope/vim-surround",
		config = function()
			require("plugins.configs.vim-surround")
		end,
	},
	{
		"is0n/fm-nvim",
		config = function()
			require("plugins.configs.fm-nvim")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
		requires = {
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"marcuscaisey/please.nvim",
		requires = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.configs.nvim-treesitter")
		end,
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"romgrk/nvim-treesitter-context",
		},
	},
	{
		"williamboman/nvim-lsp-installer",
		config = function()
			require("plugins.configs.nvim-lsp-installer")
		end,
		requires = {
			"neovim/nvim-lspconfig",
			"folke/neodev.nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.configs.nvim-cmp")
		end,
		requires = {
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("plugins.configs.lsp_signature")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.configs.lualine")
		end,
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.configs.telescope")
		end,
		requires = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.configs.Comment")
		end,
	},
	{
		"ojroques/vim-oscyank",
		config = function()
			require("plugins.configs.vim-oscyank")
		end,
	},
	{
		"sbdchd/neoformat",
		config = function()
			require("plugins.configs.neoformat")
		end,
	},
	{
		"psliwka/vim-smoothie",
		config = function()
			require("plugins.configs.vim-smoothie")
		end,
	},
	{
		"shaunsingh/nord.nvim",
		config = function()
			require("plugins.configs.nord")
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("plugins.configs.dressing")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("plugins.configs.dressing")
		end,
	},
}

require("packer").startup({
	function(use)
		for i = 1, #plugins do
			use(plugins[i])
		end
		if _Packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = { display = { open_fn = require("packer.util").float } },
})
