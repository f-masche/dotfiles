
set nocompatible              " be iMproved, required
filetype off                  " required
call plug#begin()

" Snippets
Plug 'SirVer/ultisnips'

" Tmux pane switching
Plug 'christoomey/vim-tmux-navigator'

" Show indentation guides
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1 " enable indentation guides on startup
let g:indent_guides_auto_colors=0 " disable autodiscovery of guide colors to fix colorscheme definition

" Auto close brackets and quotes
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr=1 " autoexpand carriage return

" Fuzzy file search
Plug 'kien/ctrlp.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Emmet
Plug 'mattn/emmet-vim'

" Vim surround 
Plug 'tpope/vim-surround'

" Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open = 1 " check when file is opened
let g:syntastic_check_on_wq = 0 " don't check on :wq
let g:syntastic_javascript_checkers = ['jscs'] " use jscs as javascript linter
let g:syntastic_loc_list_height=5

" Autocomplete
Plug 'valloric/youcompleteme', { 'do': './install.py' } 

" Languages 

" Javascript
Plug 'pangloss/vim-javascript' " extended javascript support
let javascript_enable_domhtmlcss=1 " enable HTML/CSS syntax highlighting

Plug 'jelera/vim-javascript-syntax'

Plug 'isRuslan/vim-es6'

" Elm
Plug 'elmcast/elm-vim'
let g:elm_syntastic_show_warnings = 1

" Color scheme
Plug 'crusoexia/vim-dracula'
let g:dracula_italic = 1

call plug#end()
filetype plugin indent on  " required
colorscheme dracula " Theme
set background=dark
syntax on
set number " show line numbers
set wildmenu " use completion menu
set nocompatible " vim only
set nomodeline " no modelines
set encoding=utf-8 " default encoding
set fileencoding=utf-8 " encode files in utf8
set backspace=indent,eol,start " backspace moves accross these
set undolevels=1000 " keep 1000 actions in undo history
set history=1000 " keep 1000 lines of command line history
set softtabstop=2 " number of spaces that 'tab' counts for when editing
set shiftwidth=2
set expandtab " tab inserts spaces
set autoindent " inherit indents
set showtabline=2 " always show tabline
set formatoptions=tcqr " autoformatting options: t: autowrap text using textwidth, c: autowrap comments, q: allow formatting of comments with gq, r automatically insert current comment leader
set copyindent " copy the structure of surrounding line
set noshiftround " do not round indents to multiples of 'shiftwidth'
set showmatch " highlight matching brackets
set ignorecase " case insensitive search
set smartcase " if caps exist, be case sensitive
set noerrorbells " do not play a sound on error
set cursorline " highlight the cursorline
set listchars=tab:>•,trail:•,extends:#,nbsp:• " strings to use in 'list'
set number " show line numbers
set ruler " show the line and column number of the cursor position
set showcmd " show partial command in the last line of the screen
set showmode " show the mode we're in
set laststatus=2 " always show a status line on the last window
set clipboard=unnamedplus " use system clipboard
set wildignore+=*/node_modules/*,*/bower_components/*
set hlsearch " highlight search results
set pumheight=5 " set height of popup
set colorcolumn=80

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
endif 

let mapleader=' '

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR><Paste>
