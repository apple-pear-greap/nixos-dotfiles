vim.pack.add({
  -- file navigation
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/refractalize/oil-git-status.nvim",
  "https://github.com/ibhagwan/fzf-lua",

  "https://github.com/nvim-mini/mini.nvim",

  -- appearance
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/xiyaowong/transparent.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",

  -- lsp
  "https://github.com/neovim/nvim-lspconfig",
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
})

require("oil").setup({
  win_options = {
    signcolumn = "yes:2",
  },
})
require('oil-git-status').setup()

require('fzf-lua').setup({})

require('mini.icons').setup()
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.jump').setup()
require('mini.jump2d').setup({
  view = {
    dim = true,        -- 是否变暗包含跳转点的行
    n_steps_ahead = 2, -- 提前显示多少步的标签
  },
})

require("lsp")

vim.cmd [[colorscheme tokyonight-storm]]
require('lualine').setup()

local cmp = require('blink.cmp')
cmp.setup({
  fuzzy = { implementation = "prefer_rust_with_warning" }
})
