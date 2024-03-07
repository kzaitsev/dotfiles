local cmd = vim.cmd

return {
		"w0ng/vim-hybrid",
		config = function()
			cmd("colorscheme hybrid")
			cmd("set termguicolors")
		end,
}
