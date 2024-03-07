return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.opt.signcolumn = "yes"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "ruby",
			callback = function()
				vim.lsp.start({
					name = "rubocop",
					cmd = { "bundle", "exec", "rubocop", "--lsp" },
				})
			end,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.rb",
			callback = function()
				vim.lsp.buf.format()
			end,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local nvim_lsp = require("lspconfig")

		local servers = {
			gopls = {},
			html = {},
			jsonls = {},
			lua_ls = {},
			tsserver = {},
			vimls = {},
			solargraph = {
				cmd = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", "stdio" },
				root_dir = nvim_lsp.util.root_pattern("Gemfile", ".git", "."),
				settings = {
					solargraph = {
						autoformat = true,
						completion = true,
						diagnostic = true,
						folding = true,
						references = true,
						rename = true,
						symbols = true,
					},
				},
			},
			marksman = {},
		}

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
