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

" switching to vim-Plug

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'townk/vim-autoclose'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf'
Plug 'hashivim/vim-terraform'

" Ansible Stuff
Plug 'pearofducks/ansible-vim'

" Python Plugins
Plug 'nvie/vim-flake8'
Plug 'vim-scripts/Pydiction'
Plug 'vim-scripts/indentpython.vim'

" tpope stuff -- awesomness
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround.git'
Plug 'tpope/vim-vividchalk'


" Golang Stuff
"Plug 'fatih/vim-go'

" Colors and Visuals
Plug 'altercation/vim-colors-solarized'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'dirtyonekanobi/cisco.vim'
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

set hidden

set backspace=2		" Make Backspace NORMAL
syntax enable		" Highlight Some Syntax
let mapleader="\<Space>"    " leader is SPACE
set noswapfile


" ColorScheme Changes
set background=dark
colorscheme solarized 	"Previously lucario

set ruler

" Universal Stuff
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
" call togglebg#map("<F5>")	" Toggle Background Colors
set number			" Line Numbers
set incsearch           	" search as characters are entered
set hlsearch            	" highlight matches

set tabstop=4	" number of visual spaces per TAB
set softtabstop=4	" number of spaces in TAB when editing
set expandtab
set showmatch
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" jk is escape
inoremap jk <esc>
" save session with leader-s
nnoremap <leader>s :mksession<CR>


"------------- Python Specific -----------------"
" Must Fix
" VirtualEnv Sanity
" py << EOF
" import os.path
" import sys
" import vim
" if 'VIRTUA_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   sys.path.insert(0, project_base_dir)
"   activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
"endif
"EOF


"------------Start Python PEP 8 stuff----------------"
"" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4
au BufRead,BufNewFile *.py set textwidth=120
au BufRead,BufNewFile *.py set autoindent
au BufRead,BufNewFile *.py set fileformat=unix
set foldlevelstart=99

highlight BadWhitespace ctermbg=red guibg=red

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1

autocmd FileType python set foldmethod=indent

"----------------- End Python PEP 8 Stuff ------------"
autocmd FileType python nnoremap <leader>r :!clear;python %<CR>

"space+f to open all folds
nnoremap <leader>f zR  

"space+F to close all folds 
nnoremap <leader>F zM   


"------------- End Python Specific ---------------"

set relativenumber
set clipboard=unnamed

" --------- Markdown Specific ---------"
"

" Ultisnips Specific
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="kk"
let g:UltiSnipsJumpBackwardTriger="ii"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips/"

"----------- Splits and Navigation -------------- "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" netrw specific
nnoremap <leader>e :Explore<cr>
nnoremap <leader>v :Vexplore<cr>
nnoremap <leader>h :Sexplore<cr>

