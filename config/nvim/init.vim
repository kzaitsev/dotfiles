if &compatible
  set nocompatible               " Be iMproved
endif

filetype off

set runtimepath^=~/.config/nvim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.config/nvim/bundle'))
  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'airblade/vim-gitgutter'

  " RSpec
  NeoBundle 'thoughtbot/vim-rspec'

  " Formatter
  NeoBundle 'Chiel92/vim-autoformat'

  " Vim ident guides
  NeoBundle 'nathanaelkane/vim-indent-guides'

  " Xkb switch
  NeoBundle 'lyokha/vim-xkbswitch'

  " Hybrid theme
  NeoBundle 'w0ng/vim-hybrid'

  " Whitespaces
  NeoBundle 'ntpeters/vim-better-whitespace'

  " VIM lightline
  NeoBundle 'itchyny/lightline.vim'

  " Ctags
  NeoBundle 'szw/vim-tags'

  " TMUX support
  NeoBundle 'jpalardy/vim-slime'
  NeoBundle 'jgdavey/tslime.vim'
  NeoBundle 'edkolev/tmuxline.vim'

  " Search
  NeoBundle 'ctrlpvim/ctrlp.vim'
  NeoBundle 'junegunn/fzf'
  NeoBundle 'rking/ag.vim'

  " NERDTree file browser
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'Xuyuanp/nerdtree-git-plugin'
  NeoBundle 'jistr/vim-nerdtree-tabs'

  " NERDCommenter
  NeoBundle 'scrooloose/nerdcommenter'

  " Editorconfig
  NeoBundle 'editorconfig/editorconfig-vim'

  " Syntax analyze ( so slow )
  NeoBundle 'scrooloose/syntastic'

  " Languages support
  " Scala
  NeoBundle 'derekwyatt/vim-scala'

  " HOCON
  NeoBundle 'GEverding/vim-hocon'

  " Ruby
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'tpope/vim-rails'

  " Crystal
  NeoBundle 'rhysd/vim-crystal'

  " Go
  NeoBundle 'fatih/vim-go'

  " Coffee
  NeoBundle 'kchmck/vim-coffee-script'

  " ReactJS
  NeoBundle 'mxw/vim-jsx'

  " Mustache, handlebars
  NeoBundle 'mustache/vim-mustache-handlebars'

  " SLIM
  NeoBundle 'onemanstartup/vim-slim'

  " Elixir
  NeoBundle 'elixir-lang/vim-elixir'
  NeoBundle 'awetzel/neovim-elixir'

  " Jade
  NeoBundle 'digitaltoad/vim-jade'

  " Haskell
  NeoBundle 'neovimhaskell/haskell-vim'

  " Stylus
  NeoBundle 'wavded/vim-stylus'

  " Fun
  NeoBundle 'wakatime/vim-wakatime'

  NeoBundle 'Bugagazavr/dasht.vim'
call neobundle#end()

filetype plugin indent on
NeoBundleCheck

set background=dark
colorscheme hybrid
syntax on

set tags=.git/tags
set dictionary=/usr/share/dict/words
set langmenu=en_US.UTF-8
set encoding=utf-8
set fileencoding=utf-8
set number

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

" Hide usless files
let NERDTreeIgnore = ['\.pyc$', '\.tags$', 'tags$', 'tags.lock$', '\.jar$', '^\.bzr$', '^\.hg$', '^\.git$', '\.swp$', '^\.svn', '^\.DS_Store$']

" Show hidden items
let NERDTreeShowHidden = 1

" Ctags
let g:vim_tags_directories = [".git", ".hg", ".svn", ".bzr"]
let g:vim_tags_gems_tags_command = "{CTAGS} -R {OPTIONS} `bundle show --paths` 2>/dev/null"
let g:vim_tags_auto_generate = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:dasht_context = { 'ruby': ['Ruby_2', 'Ruby_on_Rails_4'] }

" Ag settings
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Autocomplete
" let g:deoplete#enable_at_startup = 1

" Scala support

" Golang support
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Ruby settings
let g:ruby_path = system('rvm current')
let g:ruby_indent_access_modifier_style = 'outdent'
let ruby_operators = 1
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Tmux support
let g:slime_target = 'tmux'
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" Git support
autocmd Filetype gitcommit  setlocal spell textwidth=72

" Xkb switch settings
let g:XkbSwitchEnabled = 1
let g:XkbSwitchILayout = 'us'
let g:XkbSwitchNLayout = 'us'
let g:XkbSwitchSkipFt = [ 'nerdtree' ]
let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.dylib'

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

" Limit line size
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

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
set mouse=""

let mapleader=","
nmap <Leader>af :Autoformat<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>g :Ag!<CR>
nmap <Leader>tn :tabnew<CR>
nmap <Leader>f :FZF<CR>
nmap <Leader>s :SyntasticCheck<CR>
nmap <Leader>b :Gblame<CR>
nmap <Leader>d :Gdiff<CR>

map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>
