local api, cmd, fn, g = vim.api, vim.cmd, vim.fn, vim.g
local opt, wo = vim.opt, vim.wo
local fmt = string.format

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end


vim.cmd [[packadd packer.nvim]]

----- Plugins -----
require('packer').startup(function()
  --- Icons
  use 'kyazdani42/nvim-web-devicons'
  use {'ryanoasis/vim-devicons', opt=true}
  -- Git
  use {'tpope/vim-fugitive'}
  use {'airblade/vim-gitgutter'}
  -- Line lenght
  use {'whatyouhide/vim-lengthmatters'}
  -- Autopairs
  use {'windwp/nvim-autopairs'}
  -- Editor config
  use {'editorconfig/editorconfig-vim'}
  -- RSpec
  use {'thoughtbot/vim-rspec'}
  -- Formatter
  use {'Chiel92/vim-autoformat'}
  -- Indent guides
  use {'lukas-reineke/indent-blankline.nvim'}
  -- Hybrid theme
  use {'w0ng/vim-hybrid'}
  -- Whitespaces
  use {'ntpeters/vim-better-whitespace'}
  -- Lualine
  -- REMIND: Change it to https://github.com/hoob3rt/lualine.nvim in the future
  use {'nvim-lualine/lualine.nvim'}
  -- Search
  use {'ibhagwan/fzf-lua'}
  use {'vijaymarupudi/nvim-fzf'}
  -- File browser
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  -- Cursors
  use {'terryma/vim-multiple-cursors'}
  --- Root
  use {'ygm2/rooter.nvim'}
  -- Comments
  use {'scrooloose/nerdcommenter'}
  -- ALE
  use {'dense-analysis/ale'}
  -- Languages support
  use {'nvim-treesitter/nvim-treesitter', run='TSUpdate'}
end)

----- OPTIONS -----
local indent, width = 2, 120

--opt.shiftwidth = indent
--opt.tabstop = indent
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

vim.api.nvim_exec(
  [[
  autocmd Filetype json setlocal ts=2 sw=2 expandtab
  autocmd Filetype lua setlocal ts=2 sw=2 expandtab
  autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
]],
  true)
----- INDENT -----
require("indent_blankline").setup {
  char = "┊",
  buftype_exclude = {"terminal"}
}

----- ROOT -----
g['rooter_pattern'] = {'.git'}
g['outermost_root'] = true

----- HOTKEYS -----
g['mapleader'] = ','

map('n', '<Leader>af', '<cmd>Autoformat<CR>')
map('n', '<Leader>n', '<cmd>NvimTreeToggle<CR>')
map('n', '<Leader>tn', '<cmd>tabnew<CR>')
map('n', '<Leader>fg', "<cmd>lua require('fzf-lua').git_files()<CR>")
map('n', '<Leader>fh', "<cmd>lua require('fzf-lua').oldfiles({cwd_only=true})<CR>")
map('n', '<Leader>fa', "<cmd>lua require('fzf-lua').files()<CR>")
map('n', '<Leader>fc', "<cmd>lua require('fzf-lua').git_commits()<CR>")
map('n', '<Leader>lg', "<cmd>lua require('fzf-lua').live_grep()<CR>")
map('n', '<Leader>gst', '<cmd>GFiles?<CR>')
map('n', '<Leader>b', '<cmd>Gblame<CR>')
map('n', '<Leader>d', '<cmd>Gdiff<CR>')

----- CUSTOM COMMANDS -----
vim.api.nvim_exec(
  [[
  command! -nargs=1 Ag lua require('fzf-lua').grep({search=<q-args>})
  cabbrev ag Ag
  cabbrev AG Ag
]],
  true)

----- FZF -----
local actions = require('fzf-lua.actions')
require('fzf-lua').setup {
  preview_wrap = 'nowrap:hidden',
  default_previewer = nil,
  files = {
    cwd_only          = true,
    prompt            = 'Files❯ ',
    cmd               = '',
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
  ensure_installed = { 
    "yaml",
    "json",
    "ruby",
    "python",
    "javascript",
    "typescript",
    "go",
    "lua"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true
  }
}

----- NVIM TREE -----
require('nvim-tree').setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  view = {
    adaptive_size = false,
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = false,
      icons = {
        corner = "? ",
        edge = "? ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ? ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "?",
      info = "?",
      warning = "?",
      error = "?",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}

cmd 'set termguicolors'

----- Lualine -----
require('statusline')

----- ALE -----
g['ale_ruby_rubocop_executable'] = 'bundle'
g['ale_linters'] = {ruby={'ruby', 'rubocop'}, typescript={'eslint'}}
g['ale_lint_on_save'] = true
g['ale_lint_on_enter'] = false
g['ale_lint_on_text_changed'] = 'never'
g['ale_sign_error'] = ''
g['ale_sign_warning'] = ''
g['ale_echo_msg_error_str'] = 'E'
g['ale_echo_msg_warning_str'] = 'W'
g['ale_echo_msg_format'] = '[%linter%] %s [%severity%]'
