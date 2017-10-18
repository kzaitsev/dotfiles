if &compatible
  set nocompatible               " Be iMproved
endif

filetype off

call plug#begin('~/.vim/plugged')
  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " Line length
  Plug 'whatyouhide/vim-lengthmatters'

  " Endwise
  Plug 'tpope/vim-endwise'

  " Deoplete
  Plug 'Shougo/deoplete.nvim', { 'on': [], 'do': ':UpdateRemotePlugins' }

  " Bundler
  Plug 'tpope/vim-bundler'

  " Dasht
  Plug 'Bugagazavr/dasht.vim', { 'do': ':UpdateRemotePlugins' }

  " Editor config
  Plug 'editorconfig/editorconfig-vim'

  " RSpec
  Plug 'thoughtbot/vim-rspec', { 'for': [ 'ruby' ] }

  " Formatter
  Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }

  " Vim ident guides
  Plug 'nathanaelkane/vim-indent-guides'

  " Hybrid theme
  Plug 'w0ng/vim-hybrid'

  " Whitespaces
  Plug 'ntpeters/vim-better-whitespace'

  " VIM lightline
  Plug 'itchyny/lightline.vim'

  " Search
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  " NERDTree file browser
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

  " Tabs
  Plug 'jistr/vim-nerdtree-tabs'

  " NERDCommenter
  Plug 'scrooloose/nerdcommenter'

  " Languages support
  " Ruby
  Plug 'vim-ruby/vim-ruby', { 'for': [ 'ruby' ] }
  Plug 'tpope/vim-rails', { 'for': [ 'ruby' ] }

  " Go
  Plug 'fatih/vim-go', { 'for': 'go' }
call plug#end()

filetype plugin indent on

set background=dark
colorscheme hybrid
syntax on

set dictionary=/usr/share/dict/words
set langmenu=en_US.UTF-8
set encoding=utf-8
set fileencoding=utf-8
set number
set ignorecase
set smartcase
set incsearch
set autoread

" Use system clipboard
set clipboard=unnamed

" Disable tmp files
set nobackup
set nowb
set noswapfile

if executable('zsh')
  set shell=zsh
endif

" Whitespace removals
autocmd BufWritePre * StripWhitespace

" NERDTree
" let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_focus_on_files = 1

" Hide usls files
let NERDTreeIgnore = ['\.pyc$', '\.tags$', 'tags$', 'tags.lock$', '\.jar$', '^\.bzr$', '^\.hg$', '^\.git$', '\.swp$', '^\.svn', '^\.DS_Store$']

" Show hidden items
let NERDTreeShowHidden = 1

" Dasht
let g:dasht_context = { 'ruby': ['Ruby_2', 'Ruby_on_Rails_4'] }

" Deoplete
augroup lazy_load
  autocmd!
  autocmd! InsertEnter * call plug#load('deoplete.nvim', 'vim-endwise')
                      \| if exists('g:loaded_deoplete')
                      \|   call deoplete#enable()
                      \| endif
                      \| autocmd! lazy_load
augroup END

let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_smart_case = 0
let g:deoplete#delimiters = ['/', '.', '::', ':', '#']
let g:deoplete#max_list = 5
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_refresh_delay = 0
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'tag']
let g:deoplete#tag#cache_limit_size = 10000000
let g:neocomplete#min_pattern_length = 2

" Golang support
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = "quickfix"

" Ruby settings
let g:ruby_path = system('rbenv which ruby')
let g:ruby_indent_access_modifier_style = 'outdent'
let ruby_operators = 1
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Git support
autocmd Filetype gitcommit  setlocal spell textwidth=72

" FZF
let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ripper-tags -R'

command! -bang -nargs=* Find call fzf#vim#grep('rg --vimgrep --colors --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" '.shellescape(<q-args>), 1, <bang>0)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

" Indent guides settings
let g:indent_guides_auto_colors = 0
let indent_guides_color_change_percent = 10

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=237
autocmd VimEnter * :IndentGuidesToggle

" Indentetion settings
autocmd Filetype html         setlocal ts=2 sw=2 expandtab
autocmd Filetype yaml         setlocal ts=2 sw=2 expandtab
autocmd Filetype scala        setlocal ts=2 sw=2 expandtab
autocmd Filetype java         setlocal ts=2 sw=2 expandtab
autocmd Filetype python       setlocal ts=4 sw=4 expandtab
autocmd Filetype ruby         setlocal ts=2 sw=2 expandtab
autocmd Filetype eruby        setlocal ts=2 sw=2 expandtab
autocmd Filetype stylus       setlocal ts=2 sw=2 expandtab
autocmd Filetype vim          setlocal ts=2 sw=2 expandtab
autocmd Filetype json         setlocal ts=2 sw=2 expandtab
autocmd Filetype slim         setlocal ts=2 sw=2 expandtab
autocmd Filetype jade         setlocal ts=2 sw=2 expandtab
autocmd Filetype sass         setlocal ts=2 sw=2 expandtab
autocmd Filetype css          setlocal ts=2 sw=2 expandtab
autocmd Filetype mustache     setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript   setlocal ts=2 sw=2 expandtab
autocmd Filetype coffeescript setlocal ts=2 sw=2 expandtab
autocmd Filetype crystal      setlocal ts=2 sw=2 expandtab
autocmd Filetype cucumber     setlocal ts=2 sw=2 expandtab

au BufRead,BufNewFile *.vue   set ft=html

" Limit line size
let g:lengthmatters_start_at_column = 5000
let g:lengthmatters_on_by_default = 1

" Cursor
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  tnoremap <Esc> <c-\><c-n>
  tnoremap <C-[> <c-\><c-n>

  highlight TermCursor ctermfg=red guifg=red
endif

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Hotkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>
noremap <PageUp> <NOP>
noremap <PageDown> <NOP>
noremap <S-Left> <NOP>
noremap <S-Right> <NOP>
set mouse=""

nnoremap <C-\> :Tags <C-R><C-W><CR>

let mapleader=","
nmap <Leader>k :DashtContext <C-R><C-W><CR>
nmap <Leader>af :Autoformat<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>tn :tabnew<CR>

" Fuzzy search
nmap <Leader>fg :GFiles<CR>
nmap <Leader>ft :Tags<CR>
nmap <Leader>fa :Files<CR>
nmap <Leader>fc :Commits<CR>
nmap <Leader>aa :Ag<CR>
nmap <Leader>gst :GFiles?<CR>

nmap <Leader>b :Gblame<CR>
nmap <Leader>d :Gdiff<CR>

map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" Lightline expremental
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Gundo\|NERD' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
