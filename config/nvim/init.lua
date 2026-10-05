require("plugins")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.cmdheight = 0
vim.opt.winborder = "rounded"
vim.opt.swapfile = false

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>cd', ':Oil<CR>')
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "diagnostic messages" })

vim.keymap.set('n', '<leader>lf', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'LSP format buffer' })
