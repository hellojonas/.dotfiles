return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                }
            }
        },


        signature = {
            enabled = true,
            window = {
                show_documentation = true
            }
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },
    },
    opts_extend = { "sources.default" }
}
