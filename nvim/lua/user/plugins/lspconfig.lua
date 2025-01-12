local function setup()
    require('neodev').setup({})

    local servers = {
        lua_ls = {
            Lua = {
                completion = {
                    callSnippet = 'Replace',
                },
            },
            diagnostics = { disable = { 'missing-fields' } }
        },
        gopls = {},
        jdtls = {}
    }

    local excluded_servers = {
        "jdtls"
    }


    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
            local map = function(keys, func)
                vim.keymap.set('n', keys, func, { buffer = event.buf })
            end

            -- map('gd', require('telescope.builtin').lsp_definitions)
            map('gd', vim.lsp.buf.definition)
            map('gr', require('telescope.builtin').lsp_references)
            map('gI', require('telescope.builtin').lsp_implementations)
            map('<leader>D', require('telescope.builtin').lsp_type_definitions)
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols)
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols)
            map('<leader>rn', vim.lsp.buf.rename)
            map('<leader>rN', vim.lsp.buf.rename)
            map('<leader>ca', vim.lsp.buf.code_action)
            map('K', vim.lsp.buf.hover)
            map('gK', vim.lsp.buf.signature_help)
            map('gD', vim.lsp.buf.declaration)
            map('<leader>fd', function ()
                vim.lsp.buf.format({ async = true })
            end)

            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = event.buf,
                    callback = vim.lsp.buf.document_highlight,
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = event.buf,
                    callback = vim.lsp.buf.clear_references,
                })
            end
        end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    mason_lspconfig.setup_handlers {
        function(server_name)
            for _, value in pairs(excluded_servers) do
                if value == server_name then
                    return
                end
            end
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                settings = servers[server_name],
            }
        end,
    }
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true},
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        { 'folke/neodev.nvim', opts = {} }
    },
    config = setup
}
