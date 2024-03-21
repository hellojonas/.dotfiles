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
