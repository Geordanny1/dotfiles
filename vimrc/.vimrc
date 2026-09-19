set nocompatible
filetype plugin on
syntax on

set hlsearch
set number
set relativenumber
set relativenumber
set autochdir

let mapleader   = " "

set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab


nmap <Esc> :noh<CR>
nmap <leader>w :w<CR>

map <leader>ec :e$MYVIMRC<CR>

map <leader>f :Files<CR>
map <leader>fb :Buffers<CR>
map <leader>fh :Helptags<CR>


map <leader>r :set makeprg=

map <leader>c :make<CR>

map <leader>t :VimwikiMakeDiaryNote<CR>

map <leader>n :VimwikiIndex<CR> 

let g:vimwiki_listing_hl         = 1
let g:vimwiki_listing_hl_command = 'pygmentize -f html'
let g:vimwiki_fenced_languages   = ['python', 'javascript', 'sh', 'c']

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()

let g:user_emmet_settings = {
\  'variables': {'lang': 'es'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

