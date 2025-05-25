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

" determine if running on a remote server (via SSH)
let g:is_remote = ($SSH_CLIENT != "" || $SSH_TTY != "")

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
if (getenv('TERM_PROGRAM') != 'Apple_Terminal')
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

" Use solid characters for window separators
set fillchars+=vert:│
" set fillchars+=stl:―
" set fillchars+=stlnc:―

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
nnoremap <silent> <M-l> :vertical resize +2<CR>
nnoremap <silent> <M-h> :vertical resize -2<CR>
nnoremap <silent> <M-k> :resize +2<CR>
nnoremap <silent> <M-j> :resize -2<CR>

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
Plug 'sainnhe/everforest'
Plug 'Yggdroot/indentLine'  " Add indentation guides
Plug 'ryanoasis/vim-devicons'
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
" Only load NERDTree locally (not on server)
if !g:is_remote
  Plug 'preservim/nerdtree'
endif


" Python Development
" Only load Jedi locally (not on server)
if !g:is_remote
  Plug 'davidhalter/jedi-vim'
endif
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-python/python-syntax'
Plug 'tmhedberg/SimpylFold'

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
let g:everforest_better_performance = 1
let g:everforest_background = 'hard'
colorscheme everforest
let g:airline_theme = 'everforest'

" IndentLine settings
let g:indentLine_char = '┊'  " Character to use for indentation lines
let g:indentLine_enabled = 1 " Enable by default
let g:indentLine_color_term = 239 " Slightly darker color for the indent guides
let g:indentLine_concealcursor = 'inc' " Don't hide quotes in json files when cursor is on the line
let g:indentLine_conceallevel = 2
nnoremap <leader>ig :IndentLinesToggle<CR> " Toggle indent guides with <space>ig

" NERDTree
if !g:is_remote
  let g:NERDTreeWinPos = "left"
  let NERDTreeShowHidden=0
  let g:NERDTreeMinimalUI = 1
  let NERDTreeIgnore = ['\.pyc$', '__pycache__']
  let g:NERDTreeWinSize=30
  let g:NERDTreeHijackNetrw = 0
  nnoremap <leader>e :NERDTreeToggle<cr>
  nnoremap <leader>nb :NERDTreeFromBookmark<Space>
  nnoremap <leader>bf :NERDTreeToggle<CR>:Buffers<CR> " Show buffer list
  nnoremap <leader>nf :NERDTreeFind<cr>
  " Close NERDTree if it's the last window
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif

" FZF
" File search
nnoremap <leader>sf :Files<CR>
" Buffer search
nnoremap <leader>sb :Buffers<CR>
" Live grep search (search as you type) - requires ripgrep (https://github.com/BurntSushi/ripgrep) installed
nnoremap <leader>sg :Rg<CR>
" Word under cursor grep search
nnoremap <leader>sw :Rg <C-R><C-W><CR>
" Tags search
nnoremap <leader>t :Tags<CR>
" Search history
nnoremap <leader>s. :History<CR>
" Search in current buffer
nnoremap <leader>/ :BLines<CR>

" FZF ignore patterns for Python projects
let $FZF_DEFAULT_COMMAND = 'find . -type f -not -path "*/\.git/*" -not -path "*/\node_modules/*" -not -path "*/\venv/*" -not -path "*/\.venv/*" -not -path "*/__pycache__/*" -not -path "*/\env/*" -not -path "*/.ipynb_checkpoints/*" -not -path "*/\dist/*" -not -path "*/\build/*" -not -path "*/*.egg-info/*" -not -path "*/\.ruff_cache/*"'

" Open quickfix window automatically after grep
autocmd QuickFixCmdPost * cwindow


"----------------------------------------
" Python Settings
"----------------------------------------
"let g:python_highlight_all = 1
if !g:is_remote
  "let g:jedi#show_call_signatures = 1
endif

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
" Mini.ai-like Text Objects
"----------------------------------------
" Enhanced text objects similar to mini.ai nvim plugin
" Arguments text object (function arguments)
onoremap aa :<C-u>call <SID>SelectArguments('a')<CR>
onoremap ia :<C-u>call <SID>SelectArguments('i')<CR>
vnoremap aa :<C-u>call <SID>SelectArguments('a')<CR>
vnoremap ia :<C-u>call <SID>SelectArguments('i')<CR>

" Function to select function arguments
function! s:SelectArguments(type)
  let l:saved_pos = getpos('.')

  " Find opening parenthesis
  if search('(', 'bcW') == 0
    call setpos('.', l:saved_pos)
    return
  endif

  let l:start_pos = getpos('.')

  " Find matching closing parenthesis
  normal! %
  let l:end_pos = getpos('.')

  if a:type == 'a'
    " Select around (including parentheses)
    call setpos('.', l:start_pos)
    normal! v
    call setpos('.', l:end_pos)
  else
    " Select inside (excluding parentheses)
    call setpos('.', l:start_pos)
    normal! l
    normal! v
    call setpos('.', l:end_pos)
    normal! h
  endif
endfunction

" Next/Last text object variants
" Next parentheses
onoremap in( :<C-u>call <SID>SelectNextParens('i')<CR>
onoremap an( :<C-u>call <SID>SelectNextParens('a')<CR>
vnoremap in( :<C-u>call <SID>SelectNextParens('i')<CR>
vnoremap an( :<C-u>call <SID>SelectNextParens('a')<CR>

" Last parentheses
onoremap il( :<C-u>call <SID>SelectLastParens('i')<CR>
onoremap al( :<C-u>call <SID>SelectLastParens('a')<CR>
vnoremap il( :<C-u>call <SID>SelectLastParens('i')<CR>
vnoremap al( :<C-u>call <SID>SelectLastParens('a')<CR>

" Next quotes
onoremap in' :<C-u>call <SID>SelectNextQuotes("'", 'i')<CR>
onoremap an' :<C-u>call <SID>SelectNextQuotes("'", 'a')<CR>
onoremap in" :<C-u>call <SID>SelectNextQuotes('"', 'i')<CR>
onoremap an" :<C-u>call <SID>SelectNextQuotes('"', 'a')<CR>
vnoremap in' :<C-u>call <SID>SelectNextQuotes("'", 'i')<CR>
vnoremap an' :<C-u>call <SID>SelectNextQuotes("'", 'a')<CR>
vnoremap in" :<C-u>call <SID>SelectNextQuotes('"', 'i')<CR>
vnoremap an" :<C-u>call <SID>SelectNextQuotes('"', 'a')<CR>

" Last quotes
onoremap il' :<C-u>call <SID>SelectLastQuotes("'", 'i')<CR>
onoremap al' :<C-u>call <SID>SelectLastQuotes("'", 'a')<CR>
onoremap il" :<C-u>call <SID>SelectLastQuotes('"', 'i')<CR>
onoremap al" :<C-u>call <SID>SelectLastQuotes('"', 'a')<CR>
vnoremap il' :<C-u>call <SID>SelectLastQuotes("'", 'i')<CR>
vnoremap al' :<C-u>call <SID>SelectLastQuotes("'", 'a')<CR>
vnoremap il" :<C-u>call <SID>SelectLastQuotes('"', 'i')<CR>
vnoremap al" :<C-u>call <SID>SelectLastQuotes('"', 'a')<CR>

" Functions for next/last text objects
function! s:SelectNextParens(type)
  let l:saved_pos = getpos('.')

  if search('(', 'W') == 0
    call setpos('.', l:saved_pos)
    return
  endif

  let l:start_pos = getpos('.')
  normal! %
  let l:end_pos = getpos('.')

  if a:type == 'a'
    call setpos('.', l:start_pos)
    normal! v
    call setpos('.', l:end_pos)
  else
    call setpos('.', l:start_pos)
    normal! l
    normal! v
    call setpos('.', l:end_pos)
    normal! h
  endif
endfunction

function! s:SelectLastParens(type)
  let l:saved_pos = getpos('.')

  if search('(', 'bW') == 0
    call setpos('.', l:saved_pos)
    return
  endif

  let l:start_pos = getpos('.')
  normal! %
  let l:end_pos = getpos('.')

  if a:type == 'a'
    call setpos('.', l:start_pos)
    normal! v
    call setpos('.', l:end_pos)
  else
    call setpos('.', l:start_pos)
    normal! l
    normal! v
    call setpos('.', l:end_pos)
    normal! h
  endif
endfunction

function! s:SelectNextQuotes(quote, type)
  let l:saved_pos = getpos('.')

  if search(a:quote, 'W') == 0
    call setpos('.', l:saved_pos)
    return
  endif

  let l:start_pos = getpos('.')

  if search(a:quote, 'W') == 0
    call setpos('.', l:saved_pos)
    return
  endif

  let l:end_pos = getpos('.')

  if a:type == 'a'
    call setpos('.', l:start_pos)
    normal! v
    call setpos('.', l:end_pos)
  else
    call setpos('.', l:start_pos)
    normal! l
    normal! v
    call setpos('.', l:end_pos)
    normal! h
  endif
endfunction

function! s:SelectLastQuotes(quote, type)
  let l:saved_pos = getpos('.')
  let l:saved_line = line('.')
  let l:saved_col = col('.')

  " Find the quote pair before the cursor
  " First, find the closing quote before cursor
  if search(a:quote, 'bW') == 0
    call setpos('.', l:saved_pos)
    return
  endif

  let l:end_pos = getpos('.')
  
  " Then find the opening quote before the closing quote
  if search(a:quote, 'bW') == 0
    call setpos('.', l:saved_pos)
    return
  endif

  let l:start_pos = getpos('.')

  " Verify we found a proper pair (both quotes on same line and start before end)
  if l:start_pos[1] != l:end_pos[1] || l:start_pos[2] >= l:end_pos[2]
    call setpos('.', l:saved_pos)
    return
  endif

  if a:type == 'a'
    " Select around (including quotes)
    call setpos('.', l:start_pos)
    normal! v
    call setpos('.', l:end_pos)
  else
    " Select inside (excluding quotes)
    call setpos('.', l:start_pos)
    normal! l
    normal! v
    call setpos('.', l:end_pos)
    normal! h
  endif
endfunction

" Cursor movement to text object edges (similar to g[ and g])
nnoremap g[ :<C-u>call <SID>MoveToLeftEdge()<CR>
nnoremap g] :<C-u>call <SID>MoveToRightEdge()<CR>

function! s:MoveToLeftEdge()
  let l:chars = ['(', '[', '{', '"', "'"]
  let l:min_col = col('$')
  let l:target_col = 0

  for char in l:chars
    let l:pos = searchpos(char, 'bcnW')
    if l:pos[0] == line('.') && l:pos[1] > 0 && l:pos[1] < l:min_col
      let l:min_col = l:pos[1]
      let l:target_col = l:pos[1]
    endif
  endfor

  if l:target_col > 0
    call cursor(line('.'), l:target_col)
  endif
endfunction

function! s:MoveToRightEdge()
  let l:chars = [')', ']', '}', '"', "'"]
  let l:max_col = 0
  let l:target_col = 0

  for char in l:chars
    let l:pos = searchpos(char, 'cnW')
    if l:pos[0] == line('.') && l:pos[1] > l:max_col
      let l:max_col = l:pos[1]
      let l:target_col = l:pos[1]
    endif
  endfor

  if l:target_col > 0
    call cursor(line('.'), l:target_col)
  endif
endfunction

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
