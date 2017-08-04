set nocompatible " be iMproved, required
filetype off " required

call plug#begin()

" Autocomplete
Plug 'valloric/youcompleteme', { 'do': './install.py --tern-completer --gocode-completer' } 

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger = "<nop>"

" Show indentation guides
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1 " enable indentation guides on startup
let g:indent_guides_auto_colors=0 " disable autodiscovery of guide colors to fix colorscheme definition

" Auto close brackets and quotes
Plug 'jiangmiao/auto-pairs'

" Fuzzy file search
Plug 'kien/ctrlp.vim'
let g:ctrlp_user_command = {
\ 'types': {
  \  1: ['.git', 'cd %s && git ls-files']
\ },
\ 'fallback': 'find %s -type f'
\ }

" Ack search
Plug 'mileszs/ack.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" Emmet
Plug 'mattn/emmet-vim'

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
set clipboard=unnamedplus " use system clipboard
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

" Split and window movements
:nnoremap <leader>s :vsplit<CR> 
:nnoremap <leader>i :split<CR> 
:nnoremap <leader>j :wincmd j<CR>
:nnoremap <leader>k :wincmd k<CR>
:nnoremap <leader>h :wincmd h<CR>
:nnoremap <leader>l :wincmd l<CR>
:nnoremap <leader>b :w<CR>:bn<CR>
:nnoremap <leader>p :w<CR>:bp<CR>

" Remove highlighting on ESC in normal mode
:nnoremap <silent><ESC> :noh<CR><ESC>

map <C-n> :NERDTreeToggle<CR>

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

" Move lines  up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" for mac
vnoremap ˚ :m '<-2<CR>gv=gv
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv

" Remove highlighing after search
nnoremap <silent> <esc> :noh<return><esc>

nnoremap <C-l> :CtrlPLine<CR>

" UltiSnips completion function that tries to expand a snippet. If there's no
" snippet for expanding, it checks for completion window and if it's
" shown, selects first element. If there's no completion window it tries to
" jump to next placeholder. If there's no placeholder it just returns TAB key 
function! g:UltiSnips_Complete()
  call UltiSnips_ExpandSnippet()
  if g:ulti_expand_res == 0
      if pumvisible()
          return "\<C-n>"
      else
          call UltiSnips_JumpForwards()
          if g:ulti_jump_forwards_res == 0
             return "\<TAB>"
          endif
      endif
  endif
  return ""
endfunction

inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"

" Show cursorline only in active window
augroup CursorLine
  au!
  au VimEnter * setlocal cursorline
  au WinEnter * setlocal cursorline
  au BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
