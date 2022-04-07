vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        callback = function()
            vim.cmd 'OSCYankReg "'
        end,
        group = vim.api.nvim_create_augroup('oscyank', { clear = true }),
    }
)

