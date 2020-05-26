let mapleader="\<Space>"

set number
set inccommand=nosplit

set splitbelow
set splitright

set expandtab
set shiftwidth=2
set softtabstop=2

set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'andys8/vim-elm-syntax'
Plug 'junegunn/vim-slash'
Plug 'janko/vim-test'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

call plug#end()

" Mappings

nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

inoremap jk <esc>


nmap <silent> <leader>ev :split $MYVIMRC<CR>
nmap <silent> <leader>sv :source $MYVIMRC<CR>

nmap <leader>tf :TestFile<CR>
nmap <leader>tn :TestNearest<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>

nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]

nnoremap [ <
nnoremap ] >
onoremap [ <
onoremap ] >
xnoremap [ <
xnoremap ] >

" Learning

inoremap <esc> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Colors

highlight CocWarningFloat ctermfg=224
highlight CocErrorFloat ctermfg=224

" vim-test

let test#strategy = "neovim"

