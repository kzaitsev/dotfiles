set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

" Vundle
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'tpope/vim-fugitive'
  Plugin 'L9'

  " Vim ident guides
  Plugin 'nathanaelkane/vim-indent-guides'

  " Xkb switch
  Plugin 'lyokha/vim-xkbswitch'
	
  " Vim Tags
  Plugin 'soramugi/auto-ctags.vim'

  " Hybrid theme
  Plugin 'w0ng/vim-hybrid'

  " VIM Airline
  Plugin 'bling/vim-airline'
  Plugin 'edkolev/tmuxline.vim'

  " Search
  Plugin 'junegunn/fzf'
  Plugin 'rking/ag.vim'

  " NERDTree file browser
  Plugin 'scrooloose/nerdtree'
  Plugin 'jistr/vim-nerdtree-tabs'

  " Editorconfig
  Plugin 'editorconfig/editorconfig-vim'
  
  " Syntax analyze ( so slow )
  Plugin 'scrooloose/syntastic'

  " Autocomplete
  Plugin 'Valloric/YouCompleteMe'
  
  " Languages support
  " Scala
  Plugin 'derekwyatt/vim-scala'

  " Ruby
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'Blackrush/vim-gocode'
  Plugin 'tpope/vim-rails'

  " Go
  Plugin 'fatih/vim-go'

  " Coffee
  Plugin 'kchmck/vim-coffee-script'

  " ReactJS
  Plugin 'mxw/vim-jsx'

  " Mustache, handlebars
  Plugin 'mustache/vim-mustache-handlebars'

  " SLIM
  Plugin 'onemanstartup/vim-slim'

  " Jade
  Plugin 'digitaltoad/vim-jade'

  " Stylus
  Plugin 'wavded/vim-stylus'
call vundle#end()

filetype plugin indent on

set background=dark
colorscheme hybrid
syntax on

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

let g:airline_theme='hybrid'
let g:airline_powerline_fonts = 1

" NERDTree settings
" autocmd VimEnter * NERDTree | wincmd p
" exit from nvim if window with text has been closed
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | qa | endif

" Show tabs
let g:nerdtree_tabs_open_on_console_startup = 1

" sow NERD tree in tab
let g:nerdtree_tabs_open_on_console_startup = 1

let g:nerdtree_tabs_focus_on_files = 1

" Hide usless files
let NERDTreeIgnore = ['\.pyc$', '\.tags$', 'tags$', 'tags.lock$', '\.jar$', '^\.bzr$', '^\.hg$', '^\.git$', '\.swp$', '^\.svn', '^\.DS_Store$']

" Show hidden items
let NERDTreeShowHidden = 1

" Vim Tags
let g:auto_ctags = 1
let g:auto_ctags_filetype_mode = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" Autocomplete
" let g:deoplete#enable_at_startup = 1

" Scala support
let g:scala_sort_across_groups=1

" Golang support
let g:go_fmt_autosave = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

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

" Some customizations
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd Filetype gitcommit  setlocal spell textwidth=72

" Limit line size
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
