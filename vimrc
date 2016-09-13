set nocompatible              " be iMproved, required
filetype off                  " required

" checking for OS
let g:platform = 0
let g:distro = 0

if filereadable("/etc/debian_version")
	let g:platform="Linux"
	let g:distro="Debian"
elseif has('mac')
	let g:platform="Darwin"
	let g:distro="OSX"
elseif has('win32') || ('win16')
	let g:platform="Windows"
elseif filereadable("/etc/redhat-release")
	let g:platform="Linux"
	let g:distro="CentOs"
endif



" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'nelstrom/vim-markdown-preview'
Plugin 'elzr/vim-json'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'

" Python Plugins
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tmhedberg/SimpylFold' 

" tpope stuff -- awesomness
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'

" IDE Features - May be slow
if g:distro != 'Debian' || 'CentOs'
	Plugin 'Valloric/YouCompleteMe'
endif

" Colors and Visuals
Plugin 'altercation/vim-colors-solarized'
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'



" Plugins to Lookup or Install Later
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
" Plugin 'scrooloose/syntastic'
" Plugin 'gregsexton/MatchTag'


call vundle#end()            " required
filetype plugin indent on    " required

set hidden

set backspace=2		" Make Backspace NORMAL
syntax enable		" Highlight Some Syntax
let mapleader=","        " leader is Comma 
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
set noswapfile

if exists(":YcmCompleter")
	let g:ycm_autoclose_preview_window_after_completion=1
	map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif


" ColorScheme Changes
colorscheme lucario

" OSX Stuff
if system('uname -s') == "Darwin\n"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='cool'
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
endif

" Universal Stuff
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
call togglebg#map("<F5>")	" Toggle Background Colors
set number			" Line Numbers
set incsearch           	" search as characters are entered
set hlsearch            	" highlight matches

" NerdTree Leader
nnoremap <leader>nt :NERDTree


"------------- Python Specific -----------------"

" VirtualEnv Sanity
py << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF



"------------Start Python PEP 8 stuff----------------"
"" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4
au BufRead,BufNewFile *.py set textwidth=79
au BufRead,BufNewFile *.py set autoindent
au BufRead,BufNewFile *.py set fileformat=unix

highlight BadWhitespace ctermbg=red guibg=red

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1

autocmd FileType python set foldmethod=indent

"----------------- End Python PEP 8 Stuff ------------"
autocmd FileType python nnoremap <leader>r :!clear;python %<CR>

nnoremap <leader>za "space to open folds

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"------------- End Python Specific ---------------"


" Use SilverSearcher or Ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif
