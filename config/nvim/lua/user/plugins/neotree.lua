return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = true,
	branch = "v3.x",
	keys = {
		{ "<Leader>n", "<cmd>Neotree toggle<CR>", desc = "Toggle tree" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				mappings = {
					["p"] = function(state)
						local node = state.tree:get_node()
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end,
					["s"] = "fuzzy_finder",
					["S"] = "fuzzy_finder_directory",
				},
			},
		})
	end,
}

