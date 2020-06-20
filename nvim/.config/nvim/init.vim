let mapleader="\<Space>"

let g:netrw_liststyle = 3
let g:netrw_home=stdpath('data') . '/netrw'

let g:vim_markdown_folding_level = 2
let g:vim_markdown_fenced_languages = ['ruby=rb', 'shell=sh']

let g:ruby_host_prog='$MAIN_RUBY_HOME/bin/neovim-ruby-host'
let g:node_host_prog='$MAIN_NODEJS_HOME/.npm/bin/neovim-node-host'
let g:python_host_prog='$MAIN_PYTHON2_HOME/bin/python2'
let g:python3_host_prog='$MAIN_PYTHON3_HOME/bin/python3'

let g:fzf_history_dir = '~/.local/share/fzf-history'

set number
set inccommand=nosplit

set splitbelow
set splitright

set expandtab
set shiftwidth=2
set softtabstop=2

set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

set undofile

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'slim-template/vim-slim'
Plug 'andys8/vim-elm-syntax'
Plug 'junegunn/vim-slash'
Plug 'janko/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tomtom/tcomment_vim'
Plug 'posva/vim-vue'
Plug 'junegunn/fzf'

call plug#end()

if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif


" Mappings

nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

inoremap jk <esc>


" Meta

nmap <silent> <leader>me :split $MYVIMRC<CR>
nmap <silent> <leader>ms :source $MYVIMRC<CR>


" Navigation

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gw <Plug>(coc-diagnostic-next)
nmap <leader>gW <Plug>(coc-diagnostic-prev)
nmap <leader>ge <Plug>(coc-diagnostic-next-error)
nmap <leader>gE <Plug>(coc-diagnostic-prev-error)


" Testing

nmap <leader>tf :copen<CR> :TestFile<CR>
nmap <leader>tn :copen<CR>: TestNearest<CR>
nmap <leader>ts :copen<CR> :TestSuite<CR>
nmap <leader>tl :copen<CR> :TestLast<CR>
nmap <leader>tg :TestVisit<CR>


" Text objects

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)


" Errors

nmap <leader>fs <Plug>(coc-codeaction-selected)<CR>
nmap <leader>fl <Plug>(coc-codeaction)
nmap <leader>fc <Plug>(coc-fix-current)
nmap <leader>ds <Plug>(coc-diagnostic-info)


" Refactors

nmap <leader>rr <Plug>(coc-refactor)
vmap <leader>rr <Plug>(coc-refactor)
nmap <leader>rn <Plug>(coc-rename)

" Unimpaired

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


" fzf

nmap <c-p> :FZF<CR>


" Colors

highlight CocWarningFloat ctermfg=224
highlight CocErrorFloat ctermfg=224


" vim-test
let test#strategy="asyncrun_background"
let test#enabled_runners = ["ruby#rspec"]

function s:TrimWhitespaces()
  let l = line(".")
  let c = col(".")
  keepp %s/\s\+$//e
  call cursor(l, c)
endfunction

autocmd BufWritePre * :call s:TrimWhitespaces()
