local function nmap(key, action)
    vim.keymap.set('n', key, action, { noremap = true, silent = true })
end

nmap('<Esc>', '<cmd>nohlsearch<CR>')
nmap('<leader>db', '<cmd>bw!<CR>')
nmap('<leader>fe', '<cmd>20Lex<CR>')
nmap('<leader>r', '<cmd>source $MYVIMRC<CR>')

nmap('<C-k>', '<C-w>k')
nmap('<C-j>', '<C-w>j')
nmap('<C-h>', '<C-w>h')
nmap('<C-l>', '<C-w>l')
