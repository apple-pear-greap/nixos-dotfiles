local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
	gh('folke/tokyonight.nvim'),
	gh('neovim/nvim-lspconfig'),
	gh('stevearc/oil.nvim'),
})
vim.cmd [[colorscheme tokyonight-storm]]

vim.lsp.enable({ 'lua_ls', 'nil_ls' })

require('oil').setup()
