local g = vim.g

return 	{
  "ygm2/rooter.nvim",
  config = function()
    g["rooter_pattern"] = { ".git" }
    g["outermost_root"] = true
  end,
}
