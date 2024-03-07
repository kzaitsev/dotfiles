local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('setIndent', { clear = true })

autocmd('Filetype', {
  group = 'setIndent',
  pattern = {
    'xml',
    'html',
    'xhtml',
    'css',
    'scss',
    'javascript',
    'typescript',
    'yaml',
    'json',
    'ruby',
    'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2 expandtab'
})
