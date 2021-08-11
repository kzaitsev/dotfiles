local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	api.nvim_set_keymap(mode, lhs, rhs, options)
end

----- Plugins -----
local paq = require('paq-nvim').paq
--- Icons
paq {'kyazdani42/nvim-web-devicons'}
paq {'ryanoasis/vim-devicons', opt=true}
-- Git
paq {'tpope/vim-fugitive'}
paq {'airblade/vim-gitgutter'}
-- Line lenght
paq {'whatyouhide/vim-lengthmatters'}
-- Autopairs
paq {'windwp/nvim-autopairs'}
-- Editor config
paq {'editorconfig/editorconfig-vim'}
-- RSpec
paq {'thoughtbot/vim-rspec'}
-- Formatter
paq {'Chiel92/vim-autoformat'}
-- Indent guides
paq {'lukas-reineke/indent-blankline.nvim'}
-- Hybrid theme
paq {'w0ng/vim-hybrid'}
-- Whitespaces
paq {'ntpeters/vim-better-whitespace'}
-- Lualine
-- REMIND: Change it to https://github.com/hoob3rt/lualine.nvim in the future
paq {'shadmansaleh/lualine.nvim'}
-- Search
paq {'ibhagwan/fzf-lua'}
paq {'vijaymarupudi/nvim-fzf'}
-- File browser
paq {'kyazdani42/nvim-tree.lua'}
-- Cursors
paq {'terryma/vim-multiple-cursors'}
-- Comments
paq {'scrooloose/nerdcommenter'}
-- ALE
paq {'dense-analysis/ale'}
-- Languages support
paq {'nvim-treesitter/nvim-treesitter', run='TSUpdate'}

----- OPTIONS -----
local indent, width = 2, 120

opt.shiftwidth = indent
opt.tabstop = indent
opt.textwidth = width
opt.background = 'dark'
opt.dictionary = '/usr/share/dict/words'
opt.langmenu = 'en_US.UTF-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.autoread = true
opt.backup = false
opt.wb = false
opt.swapfile = false
opt.shell = 'zsh'
opt.clipboard = 'unnamed'

cmd 'colorscheme hybrid'
cmd 'filetype plugin indent on'
cmd 'syntax on'

----- INDENT -----
require("indent_blankline").setup {
    char = "┊",
    buftype_exclude = {"terminal"}
}

----- HOTKEYS -----
g['mapleader'] = ','

map('n', '<Leader>af', '<cmd>Autoformat<CR>')
map('n', '<Leader>n', '<cmd>NvimTreeToggle<CR>')
map('n', '<Leader>tn', '<cmd>tabnew<CR>')
map('n', '<Leader>fg', "<cmd>lua require('fzf-lua').git_files()<CR>")
map('n', '<Leader>fa', "<cmd>lua require('fzf-lua').files({cwd=nil})<CR>")
map('n', '<Leader>fc', "<cmd>lua require('fzf-lua').git_commits()<CR>")
map('n', '<Leader>lg', "<cmd>lua require('fzf-lua').live_grep()<CR>")
map('n', '<Leader>gst', '<cmd>GFiles?<CR>')
map('n', '<Leader>b', '<cmd>Gblame<CR>')
map('n', '<Leader>d', '<cmd>Gdiff<CR>')

----- FZF -----
local actions = require('fzf-lua.actions')
require('fzf-lua').setup {
	preview_wrap = 'nowrap:hidden',
	default_previewer = nil,
  grep = {
    prompt            = 'Rg❯ ',
    input_prompt      = 'Grep For❯ ',
    cmd               = "rg --vimgrep --hidden --column --line-number --no-heading --color=always --smart-case -g '!{.git,vendor,node_modules}/*'",
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["ctrl-q"]      = actions.file_sel_to_qf,
      ["ctrl-y"]      = function(selected) print(selected[2]) end,
    }
  },
}

----- TREESITTER -----
require('nvim-treesitter.configs').setup {
	ensure_installed = "maintained",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	}
}

----- Lualine -----
require('statusline')

----- ALE -----
g['ale_ruby_rubocop_executable'] = 'bundle'
g['ale_linters'] = {ruby={'ruby', 'rubocop'}}
g['ale_lint_on_save'] = true
g['ale_lint_on_enter'] = false
g['ale_lint_on_text_changed'] = 'never'
g['ale_sign_error'] = ''
g['ale_sign_warning'] = ''
g['ale_echo_msg_error_str'] = 'E'
g['ale_echo_msg_warning_str'] = 'W'
g['ale_echo_msg_format'] = '[%linter%] %s [%severity%]'
