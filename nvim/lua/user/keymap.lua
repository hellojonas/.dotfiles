local function nmap(key, action)
    vim.keymap.set('n', key, action, { noremap = true, silent = true })
end

nmap('<Esc>', '<cmd>nohlsearch<CR>')
nmap('<leader>fe', '<cmd>Explore<CR>')
nmap('<leader>db', '<cmd>bdelete!<CR>')
nmap('<leader>gc', '<cmd>e $MYVIMRC<CR>')
