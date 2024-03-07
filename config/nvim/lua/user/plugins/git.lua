return {
  {
    'tpope/vim-fugitive',
    lazy = true,
    keys = {
      { "<Leader>d", "<cmd>Git diff<CR>", desc = "Show GIT diff" },
      { "<Leader>b", "<cmd>Git blame<CR>", desc = "Show GIT blame" },
    },
  },
  {
    "airblade/vim-gitgutter",
    branch = "main",
  },
}
