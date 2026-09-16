local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    gh('Mofiqul/dracula.nvim'),
    gh('neovim/nvim-lspconfig'),
})

require('dracula').setup()
vim.cmd[[colorscheme dracula]]

vim.lsp.enable({ "nil_ls","lua_ls" })
