local function nmap(key, action)
    vim.keymap.set('n', key, action, { noremap = true, silent = true })
end

nmap('<Esc>', '<cmd>nohlsearch<CR>')
nmap('<leader>db', '<cmd>bw!<CR>')
nmap('<leader>dba', '<cmd>%bw!<CR>')
nmap('<leader>fe', '<cmd>Ex<CR>')
nmap('<leader>r', '<cmd>source $MYVIMRC<CR>')

nmap('<C-k>', '<C-w>k')
nmap('<C-j>', '<C-w>j')
nmap('<C-h>', '<C-w>h')
nmap('<C-l>', '<C-w>l')

nmap('gh', '<cmd>diffget //2<CR>')
nmap('gl', '<cmd>diffget //3<CR>')

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
