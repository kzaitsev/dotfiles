local opt = vim.opt

----- OPTIONS -----
local indent, width = 2, 120

--opt.shiftwidth = indent
--opt.tabstop = indent
opt.textwidth = width
opt.background = "dark"
opt.dictionary = "/usr/share/dict/words"
opt.langmenu = "en_US.UTF-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.autoread = true
opt.backup = false
opt.wb = false
opt.swapfile = false
opt.shell = "zsh"
opt.clipboard = "unnamed"
opt.mouse = ""

vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
