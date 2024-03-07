return {
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		keys = {
			{ "<Leader>fg", "<cmd>lua require('fzf-lua').git_files()<CR>", desc = "Search files from GIT" },
			{
				"<Leader>fh",
				"<cmd>lua require('fzf-lua').oldfiles({cwd_only=true})<CR>",
				desc = "Search files from GIT history",
			},
			{ "<Leader>fa", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Search by all files" },
			{ "<Leader>fc", "<cmd>lua require('fzf-lua').git_commits()<CR>", desc = "Search by commits" },
			{ "<Leader>lg", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Search by live grep" },
		},
    cmd = {
      "Ag",
    },
		config = function()
			vim.api.nvim_exec(
				[[
        command! -nargs=1 Ag lua require('fzf-lua').grep({search=<q-args>})
        cabbrev ag Ag
        cabbrev AG Ag
        ]],
				true
			)

			local actions = require("fzf-lua.actions")
			require("fzf-lua").setup({
				preview_wrap = "nowrap:hidden",
				default_previewer = nil,
				files = {
					cwd_only = true,
					prompt = "Files❯ ",
					cmd = "",
					git_icons = true, -- show git icons?
					file_icons = true, -- show file icons?
					color_icons = true, -- colorize file|git icons
					actions = {
						["default"] = actions.file_edit,
						["ctrl-s"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
						["ctrl-t"] = actions.file_tabedit,
						["ctrl-q"] = actions.file_sel_to_qf,
						["ctrl-y"] = function(selected)
							print(selected[2])
						end,
					},
				},
				grep = {
					prompt = "Rg❯ ",
					input_prompt = "Grep For❯ ",
					cmd = "rg --vimgrep --hidden --column --line-number --no-heading --color=always --smart-case -g '!{.git,vendor,node_modules}/*'",
					git_icons = true, -- show git icons?
					file_icons = true, -- show file icons?
					color_icons = true, -- colorize file|git icons
					actions = {
						["default"] = actions.file_edit,
						["ctrl-s"] = actions.file_split,
						["ctrl-v"] = actions.file_vsplit,
						["ctrl-t"] = actions.file_tabedit,
						["ctrl-q"] = actions.file_sel_to_qf,
						["ctrl-y"] = function(selected)
							print(selected[2])
						end,
					},
				},
			})
		end,
	},
	"vijaymarupudi/nvim-fzf",
}
