return {
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  {
     'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
  },
  {
      'numToStr/Comment.nvim',
      opts = {},
      lazy = false,
  },
  {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp"
  },
  {
      'lewis6991/gitsigns.nvim',
      config= true
  }
}
