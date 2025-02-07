"----------------------------------------
" Basic Settings
"----------------------------------------
set nocompatible              
let mapleader=" "             
set number                    
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

"----------------------------------------
" UI Configuration
"----------------------------------------
set guicursor+=a:blinkon1    
set laststatus=2             
set noshowmode               
set signcolumn=yes           
set background=dark

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

" Window navigation
nnoremap <C-h> <C-w>h       
nnoremap <C-j> <C-w>j       
nnoremap <C-k> <C-w>k       
nnoremap <C-l> <C-w>l       

" Tab settings
set tabline=%!MyTabLine()    
nnoremap <leader>tn :tabnew<CR>     
nnoremap <leader>tc :tabclose<CR>   
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
Plug 'itchyny/lightline.vim'

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
Plug 'Vimjas/vim-python-pep8-indent' 
Plug 'vim-python/python-syntax'
Plug 'tmhedberg/SimpylFold'    

Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
" enable status line always
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_extensions = []

call plug#end()

"----------------------------------------
" Plugin Settings
"----------------------------------------
" Theme
colorscheme gruvbox

" NERDTree
" let NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
nnoremap <leader>nn :NERDTreeToggle<cr>
nnoremap <leader>nb :NERDTreeFromBookmark<Space>
nnoremap <leader>nf :NERDTreeFind<cr>

" FZF
nnoremap <C-p> :Files<CR>    
nnoremap <C-g> :Rg<CR>       
nnoremap <leader>t :Tags<CR> 

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
