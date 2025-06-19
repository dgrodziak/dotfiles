set nocompatible  " not vi compatible
let mapleader = "\<Space>" " set leader key to space

"------------------
" syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " highlight matching [{()}]
set autoindent " auto indent
filetype plugin indent on " enable filetype detection, plugin, indent

colorscheme industry

"---------------------
" basic editing config
"---------------------
set shortmess+=I " disable the default Vim startup message
set number " show line numbers
set relativenumber " show line numbers relative to the current line
set laststatus=2 " always show status line at the bottom
set tabstop=4 " tabs are 4 spaces
set shiftwidth=4 " when indenting with '>', use 4 spaces
set expandtab " when pressing tab, insert spaces
set showcmd " show incomplete command in status bar
set wildmenu " display completion matches in a status line
set ruler " show cursor position as a % of the file in the status line
set scrolloff=5 " show lines above/below cursor (when possible)
set timeout timeoutlen=1000 ttimeoutlen=100 " faster timeout for key codes
" allow backspacing over everything in insert mode
set backspace=indent,eol,start 
set hidden " allow auto-hiding of buffers
set ignorecase " case-insensitive search
set smartcase " search becomes case-sensitive if capital letters included
set incsearch " incremental search (search as you type)
set hlsearch " highlight search results
set mouse+=a " enable all-mode mouse support (scrolling, selecting, etc)

set undodir=~/.vim/undodir
set undofile " maintain undo history between sessions

"-------------
" misc configs
"-------------

" unbind keys
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" toggle relative numbering
nnoremap <C-n> :set rnu!<CR>

" quicker way to move windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" prevent the use of arrow keys in normal and insert modes
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" disable audible bell (annoying)
set noerrorbells visualbell t_vb= 

" The following (perhaps unnecessary) are pulled from the defaults.vim file
" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | exe 'au!' | augroup END"
augroup vimStartup
au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"---------------
" plugin configs
"---------------

" nerdtree
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" ctrlp
nnoremap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0 " don't switch buffers when opening CtrlP
let g:ctrlp_show_hidden = 1 " show hidden files by default

" mundo
nnoremap <Leader>u :MundoToggle<CR>

