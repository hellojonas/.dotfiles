local function setup()
    require('telescope').setup {
        defaults = {
            mappings = {
            }
        },
        extensions = {
            file_browser = {
                theme = 'ivy',
                layout_strategy = 'horizontal',
                layout_config = {
                    prompt_position = "top",
                }
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                }
            }
        }
    }
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('n', '<leader>fe', '<cmd>Telescope file_browser<CR>', {})
    vim.keymap.set('n', '<leader>eb', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>', {})

    require("telescope").load_extension("ui-select")
end

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-file-browser.nvim'
    },
    config = setup
}
