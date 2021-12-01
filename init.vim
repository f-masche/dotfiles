set nocompatible " be iMproved, required
filetype off " required

call plug#begin()

" Show indentation guides
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1 " enable indentation guides on startup
let g:indent_guides_auto_colors=0 " disable autodiscovery of guide colors to fix colorscheme definition

"File tree
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Auto close brackets and quotes
Plug 'jiangmiao/auto-pairs'

" Nerd commenter
Plug 'scrooloose/nerdcommenter'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim surround
Plug 'tpope/vim-surround'

" Fuzzy search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Typescript syntax
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'cakebaker/scss-syntax.vim'

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

lua <<EOF
require'nvim-tree'.setup {
  view = {
    auto_resize = true
    }
  }
EOF

" Split and window movements
nnoremap <leader>v :vnew<CR>
nnoremap <leader>i :new<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>tt :NvimTreeToggle<CR>
nnoremap <leader>tr :NvimTreeRefresh<CR>
nnoremap <leader>tf :NvimTreeFindFile<CR>
" last used buffer
nnoremap <leader>p :w<CR>:b #<CR>

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
nnoremap <esc> :noh<return><esc>

" Show cursorline only in active window
augroup CursorLine
  au!
  au VimEnter * setlocal cursorline
  au WinEnter * setlocal cursorline
  au BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" switch tabs
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>

" Search selected text
vnoremap // y/<C-R>"<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OrganizeImport   :call     CocAction('runCommand', 'editor.action.organizeImport')

command! -nargs=0 Prettier :CocCommand prettier.formatFile

command! -nargs=0 Refresh :source $MYVIMRC

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files theme=dropdown<cr>
nnoremap <leader>fg <cmd>Telescope live_grep theme=dropdown<cr>
nnoremap <leader>fb <cmd>Telescope buffers theme=dropdown<cr>
nnoremap <leader>fh <cmd>Telescope help_tags theme=dropdown<cr>
