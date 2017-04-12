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
Plugin 'scrooloose/nerdcommenter'
Plugin 'mileszs/ack.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'elzr/vim-json'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'townk/vim-autoclose'

" Ansible Stuff
Plugin 'pearofducks/ansible-vim'

" Python Plugins
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'

" tpope stuff -- awesomness
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-vividchalk'


" IDE Features - May be slow
"if g:distro != 'Debian' || 'CentOs'
"	Plugin 'Valloric/YouCompleteMe'
" endif

" Writing
if g:distro != 'Debian' || 'CentOs'
	Plugin 'godlygeek/tabular'
    Bundle 'gabrielelana/vim-markdown'
	Plugin 'iamcco/markdown-preview.vim'
	Plugin 'junegunn/goyo.vim'
	Plugin 'bwmcadams/vim-deckset'
    Plugin 'xolox/vim-notes'
    Plugin 'xolox/vim-misc'
endif

" Colors and Visuals
Plugin 'altercation/vim-colors-solarized'
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'
Plugin 'dirtyonekanobi/cisco.vim'


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
let mapleader="\<Space>"    " leader is SPACE
set noswapfile

if exists(":YcmCompleter")
	let g:ycm_autoclose_preview_window_after_completion=1
	map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif


" ColorScheme Changes
colorscheme lucario 	"Previously lucario

set ruler

" OSX Stuff
if system('uname -s') == "Darwin\n"
set guifont=Inconsolata\ for\ Powerline:h15
set laststatus=2
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]%{fugitive#statusline()}
endif

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
au BufRead,BufNewFile *.py set textwidth=100
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


" Use SilverSearcher or Ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

let g:notes_directories = [ '~/notes', '~/Documents/Notes' ]

set relativenumber
set clipboard=unnamed

" --------- Markdown Specific ---------"
"
nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode

let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"

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

autocmd FileType yaml setlocal autoindent ts=2 sts=2 sw=2 expandtab
