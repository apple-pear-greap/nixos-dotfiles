vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/xiyaowong/transparent.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  {
    src = "https://github.com/saghen/blink.cmp",
    version = 'v1'
  },
})
require("oil").setup()
require("lsp")

vim.cmd [[colorscheme tokyonight-storm]]
local cmp = require('blink.cmp')
cmp.setup()
