set nocompatible " be iMproved, required
filetype off " required

call plug#begin()

" Show indentation guides
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1 " enable indentation guides on startup
let g:indent_guides_auto_colors=0 " disable autodiscovery of guide colors to fix colorscheme definition

" Auto close brackets and quotes
Plug 'jiangmiao/auto-pairs'

" Git
Plug 'tpope/vim-fugitive'

" FZF fuzzy file search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" NERD Tree
Plug 'scrooloose/nerdtree'
let NERDTreeWinSize=32

" Syntastic
Plug 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1

" Vim surround
Plug 'tpope/vim-surround'

" Javascript
Plug 'pangloss/vim-javascript' " extended javascript support
let javascript_enable_domhtmlcss=1 " enable HTML/CSS syntax highlighting

Plug 'jelera/vim-javascript-syntax'

Plug 'isRuslan/vim-es6'

Plug 'leafgarland/typescript-vim'

" Plug 'Quramy/tsuquyomi'

" Typescript syntax
Plug 'HerringtonDarkholme/yats.vim'

Plug 'mhartington/nvim-typescript', {'build': './install.sh'}

" For async completion
Plug 'Shougo/deoplete.nvim'

" Plug 'mhartington/deoplete-typescript'

" For Denite features
" Plug 'Shougo/denite.nvim'

" Color scheme
Plug 'dracula/vim'
let g:dracula_italic = 1

call plug#end()
filetype plugin indent on  " required
colorscheme dracula " Theme
set background=dark
syntax on
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:ver25-iCursor-blinkwait175-blinkoff150-blinkon175
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
set clipboard=unnamed " use system clipboard
set wildignore+=*/node_modules/*,*/bower_components/*
set hlsearch " highlight search results
set pumheight=5 " set height of popup
set colorcolumn=80
set splitbelow " split below of current window
set splitright " split right of current window
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
set mouse=a
endif

if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
endif

let mapleader=' '

let g:deoplete#enable_at_startup = 1

" Auto cd into root directory of NERDTree
let NERDTreeChDirMode = 2
let NERDTreeMarkBookmarks = 0
let NERDTreeMinimalUI = 1

" Split and window movements
:nnoremap <leader>s :vsplit<CR>
:nnoremap <leader>i :split<CR>
:nnoremap <leader>j :wincmd j<CR>
:nnoremap <leader>k :wincmd k<CR>
:nnoremap <leader>h :wincmd h<CR>
:nnoremap <leader>l :wincmd l<CR>
:nnoremap <leader>b :w<CR>:bn<CR>
:nnoremap <leader>p :w<CR>:bp<CR>

map <C-\> :NERDTreeToggle<CR>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR><Paste>

" Keep selection when changing indentation
vnoremap > >gv
vnoremap < <gv
noremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Remove highlighing after search
" nnoremap <esc> :noh<return><esc>

" Search for line
nnoremap <C-l> :CtrlPLine<CR>

" Show cursorline only in active window
augroup CursorLine
  au!
  au VimEnter * setlocal cursorline
  au WinEnter * setlocal cursorline
  au BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>

noremap <C-p> :GFiles .<CR>
noremap <C-b> :Buffers .<CR>

noremap <C-_> :NERDTreeToggle<CR>

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
