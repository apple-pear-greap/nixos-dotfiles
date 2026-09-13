local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    gh('Mofiqul/dracula.nvim'),
})

require('dracula').setup()
vim.cmd[[colorscheme dracula]]
