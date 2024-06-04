require('user.settings')
require('user.keymap')
require('user.lazy')

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local telescope_on_startup_group = vim.api.nvim_create_augroup('TelescopOnStartup', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
    group = telescope_on_startup_group,
    callback = function(e)
        require('telescope.builtin').find_files()
    end
})
