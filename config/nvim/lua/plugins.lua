local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
  -- file navigation
  gh('stevearc/oil.nvim'),
  gh('refractalize/oil-git-status.nvim'),
  gh('luukvbaal/nnn.nvim'),
  gh('ibhagwan/fzf-lua'),

  gh('nvim-mini/mini.nvim'),

  -- appearance
  gh('folke/tokyonight.nvim'),
  gh('xiyaowong/transparent.nvim'),
  gh('nvim-lualine/lualine.nvim'),

  -- lsp
  gh('neovim/nvim-lspconfig'),
  gh('saghen/blink.lib'),
  gh('saghen/blink.cmp'),
})

require("oil").setup({
  win_options = {
    signcolumn = "yes:2",
  },
})
require('oil-git-status').setup()

local nnn_builtin = require('nnn').builtin
require('nnn').setup({
  mappings = {
    { "<C-t>", nnn_builtin.open_in_tab },
    { "<C-s>", nnn_builtin.open_in_split },
    { "<C-v>", nnn_builtin.open_in_vsplit },
  }
})



require('mini.icons').setup()
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
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
  keymap = {
    preset = "default",
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-g>'] = { 'cancel', 'fallback' },
    ['<Tab>'] = {
      'accept',
      'snippet_forward',
      'fallback'
    }
  },
  appearance = {
    nerd_font_variant = "mono",
    use_nvim_cmp_as_default = true,
  },
  fuzzy = { implementation = "prefer_rust_with_warning" }
})
