local function setup()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "go", "javascript", "bash", "comment", "html" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
    })

    require("lazy").setup({ {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
        end
    } })
end

return {
    'nvim-treesitter/nvim-treesitter',
    config = setup,
}
