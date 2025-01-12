return {
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-sleuth',
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    },
}
