require("user.settings.leader")
require("user.settings.common")
require("user.settings.keymaps")
require("user.settings.file_types")

----- Plugins -----
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("user.plugins", {
	defaults = {
		lazy = false,
	},
})
