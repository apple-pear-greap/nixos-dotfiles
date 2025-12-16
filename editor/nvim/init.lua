-- Enable true color and syntax highlighting
vim.opt.termguicolors = true
vim.cmd("syntax on")

require("config.option")
require("config.keybinds")
require("config.lazy")
