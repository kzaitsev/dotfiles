return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		event = "VeryLazy",
		keys = function()
			local fzf = require("fzf-lua")

			return {
				{ "<leader>fg", fzf.git_files, desc = "Search files from GIT" },
				{ "<leader>fa", fzf.files, desc = "Search all files" },
				{ "<leader>fc", fzf.git_commits, desc = "Search commits" },
				{ "<leader>lg", fzf.live_grep, desc = "Live grep search" },
				{ "<leader>fb", fzf.buffers, desc = "Search buffers" },
				{
					"<leader>fh",
					function()
						fzf.oldfiles({ cwd_only = true })
					end,
					desc = "Search recent files"
				},
			}
		end,
		config = function(_, opts)
			local fzf = require("fzf-lua")
			fzf.setup(opts)

			vim.api.nvim_create_user_command("Ag", function(args)
				fzf.grep({ search = args.args })
			end, { nargs = 1 })
		end,
		opts = {
			fzf_colors = true,
			defaults = {
				formatter = "path.dirname_first",
			},
			winopts = {
				width = 0.85,
				height = 0.80,
				preview = {
					wrap = false,
					layout = "vertical",
					vertical = "down:45%",
				},
			},
			files = {
				cwd_only = true,
				prompt = "Files> ",
				git_icons = true,
				file_icons = true,
				color_icons = true,
			},
			git_files = {
				prompt = "GitFiles> ",
				git_icons = true,
				file_icons = true,
				color_icons = true,
			},
			grep = {
				prompt = "Grep> ",
				input_prompt = "Grep For> ",
				cmd = "rg --vimgrep --hidden --column --line-number --no-heading --color=always --smart-case",
				git_icons = true,
				file_icons = true,
				color_icons = true,
			},
		},
	},
}
