return {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.2",
  dependencies = { "RRethy/nvim-treesitter-endwise" },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "json",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "javascript",
        "html",
        "ruby",
        "python",
        "yaml",
        "toml",
        "rust",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
