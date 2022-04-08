-- install packer and all of the packages if packer has not been installed already
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local plugins = {
    'wbthomason/packer.nvim',
    'stevearc/dressing.nvim',
    'tpope/vim-eunuch',
    'tpope/vim-repeat',
    'vim-scripts/ReplaceWithRegister',
    'tpope/vim-surround',
    'tpope/vim-fugitive',
    'tpope/vim-unimpaired',
    'christoomey/vim-tmux-navigator',
    'marcuscaisey/please.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins.configs.nvim-treesitter')
        end,
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'romgrk/nvim-treesitter-context',
        },
    },
    {
        'williamboman/nvim-lsp-installer',
        config = function()
            require('plugins.configs.nvim-lsp-installer')
        end,
        requires = {
            'neovim/nvim-lspconfig',
        }
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            require('plugins.configs.nvim-cmp')
        end,
        requires = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
        },
    },
    {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('plugins.configs.lsp_signature')
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('plugins.configs.lualine')
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
    },
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('plugins.configs.telescope')
        end,
        requires = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
            },
        },
    },
    {
        'tpope/vim-commentary',
        config = function()
            require('plugins.configs.vim-commentary')
        end
    },
    {
        'ggandor/lightspeed.nvim',
        config = function()
            require('plugins.configs.lightspeed')
        end
    },
    {
        'ojroques/vim-oscyank',
        config = function()
            require('plugins.configs.vim-oscyank')
        end
    },
    {
        'sbdchd/neoformat',
        config = function()
            require('plugins.configs.neoformat')
        end
    },
    {
        'psliwka/vim-smoothie',
        config = function()
            require('plugins.configs.vim-smoothie')
        end
    },
    {
        'shaunsingh/nord.nvim',
        config = function()
            require('plugins.configs.nord')
        end
    },
}

require('packer').startup({
    function(use)
        for i = 1, #plugins do
            use(plugins[i])
        end
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = { display = { open_fn = require('packer.util').float } },
})

