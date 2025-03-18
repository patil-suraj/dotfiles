"----------------------------------------
" Basic Settings
"----------------------------------------
set nocompatible
set encoding=UTF-8
let mapleader=" "
set number
set relativenumber
set cursorline
set mouse=a
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" use clipboard
if has('mac')
  set clipboard=unnamed     " macOS clipboard
elseif has('unix')
  set clipboard=unnamedplus " Linux clipboard
endif

" Fast saving, qutting
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q<cr>

" Enable filetype plugins
filetype plugin on
filetype indent on
syntax on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

" Persistent undo
" set undodir=~/.vim/undodir
" set undofile

" Copy to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Quickly edit/reload vimrc
nnoremap <leader>ec :e $MYVIMRC<CR>
nnoremap <leader>sc :source $MYVIMRC<CR>

" Toggle relative line numbers
nnoremap <leader>rl :set relativenumber!<CR>

" Quick buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Remap Esc to exit terminal mode
tnoremap <Esc> <C-\\><C-n><CR>

" Change current directory to file's directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" UndoTree toggle
nnoremap <leader>u :UndotreeToggle<CR>

" Search and replace word under cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

"----------------------------------------
" UI Configuration
"----------------------------------------
set guicursor+=a:blinkon1
set laststatus=2
set noshowmode
set signcolumn=yes
set background=dark
set scrolloff=10

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Remap half-page and paragraph movements to center cursor
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz
nnoremap n nzz
nnoremap N Nzz

"----------------------------------------
" Search Settings
"----------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

"----------------------------------------
" Window and Tab Management
"----------------------------------------
" Split settings
set splitbelow
set splitright

" Window split shortcuts
nnoremap <leader>sh :split<CR>
nnoremap <leader>sv :vsplit<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Better split resizing
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
" Continuous resizing with Alt/Option key
nnoremap <silent> <M-l> :vertical resize +1<CR>
nnoremap <silent> <M-h> :vertical resize -1<CR>
nnoremap <silent> <M-k> :resize +1<CR>
nnoremap <silent> <M-j> :resize -1<CR>

" Tab settings
set tabline=%!MyTabLine()
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabprevious<CR>

" Custom tab line functions
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor
  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

"----------------------------------------
" Plugin Management
"----------------------------------------
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

" Theme and UI
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'  " Add indentation guides
Plug 'ryanoasis/vim-devicons'
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
" enable status line always
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_extensions = []
let g:airline_powerline_fonts = 1

" File Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" Code Navigation
" Plug 'universal-ctags/ctags'
" Plug 'ludovicchabant/vim-gutentags'

" Search
Plug 'nvim-lua/plenary.nvim'

" Python Development
" Plug 'davidhalter/jedi-vim'
"Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'vim-python/python-syntax'
"Plug 'tmhedberg/SimpylFold'

" Git Integration
Plug 'tpope/vim-fugitive'               " Git commands in Vim
Plug 'airblade/vim-gitgutter'           " Shows git diff in the sign column

" Text manipulation
Plug 'tpope/vim-surround'               " Easily change surroundings (parentheses, brackets, etc.)
Plug 'tpope/vim-commentary'             " Comment/uncomment with gc
Plug 'jiangmiao/auto-pairs'             " Auto-close brackets, quotes, etc.
call plug#end()

"----------------------------------------
" Plugin Settings
"----------------------------------------
" Theme
colorscheme gruvbox

" IndentLine settings
let g:indentLine_char = '┊'  " Character to use for indentation lines
let g:indentLine_enabled = 1 " Enable by default
let g:indentLine_color_term = 239 " Slightly darker color for the indent guides
let g:indentLine_concealcursor = 'inc' " Don't hide quotes in json files when cursor is on the line
let g:indentLine_conceallevel = 2
nnoremap <leader>ig :IndentLinesToggle<CR> " Toggle indent guides with <space>ig

" NERDTree
" let NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let g:NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>nb :NERDTreeFromBookmark<Space>
nnoremap <leader>bf :NERDTreeToggle<CR>:Buffers<CR> " Show buffer list
nnoremap <leader>nf :NERDTreeFind<cr>
" Close NERDTree if it's the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" FZF
" File search
nnoremap <leader>sf :Files<CR>
" Buffer search
nnoremap <leader>sb :Buffers<CR>
" Grep search (keep buffers)
nnoremap <leader>sg :silent grep -r "" .<Left><Left><Left>
" Word under cursor grep search
nnoremap <leader>sw :silent grep -r <cword> .<CR>
" Tags search
nnoremap <leader>t :Tags<CR>
" Search history
nnoremap <leader>s. :History<CR>
" Search in current buffer
nnoremap <leader>/ :BLines<CR>

" Open quickfix window automatically after grep
autocmd QuickFixCmdPost * cwindow


"----------------------------------------
" Python Settings
"----------------------------------------
"let g:python_highlight_all = 1       
"let g:jedi#show_call_signatures = 1  

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space>f za                
au FileType python map <buffer> F :set foldmethod=indent<cr>

" Python navigation
au FileType python map <buffer> <leader>1 /class<CR>  
au FileType python map <buffer> <leader>2 /def<CR>    
au FileType python map <buffer> <leader>C ?class<CR>  
au FileType python map <buffer> <leader>D ?def<CR>    

" Python shortcuts
au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f #--- <esc>a

"----------------------------------------
" Auto Commands
"----------------------------------------
" Auto install plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Enhanced command-line completion
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" Search for visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Show trailing whitespace and spaces before tabs
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"----------------------------------------
" Git Integration Settings
"----------------------------------------
" Fugitive shortcuts
nnoremap <leader>gs :Git<CR>            " Git status
nnoremap <leader>gc :Git commit<CR>     " Git commit
nnoremap <leader>gd :Gdiffsplit<CR>     " Git diff
nnoremap <leader>gb :Git blame<CR>      " Git blame
nnoremap <leader>gl :Gclog<CR>          " Git log

" GitGutter settings
let g:gitgutter_enabled = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
nnoremap <leader>gg :GitGutterToggle<CR>
