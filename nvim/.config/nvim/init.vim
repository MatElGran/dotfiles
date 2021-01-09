let mapleader="\<Space>"
let maplocalleader="\<Space>"
let g:netrw_liststyle = 3
let g:netrw_home=stdpath('data') . '/netrw'

let g:ruby_host_prog='$MAIN_RUBY_HOME/bin/neovim-ruby-host'
let g:node_host_prog='$MAIN_NODEJS_HOME/.npm/bin/neovim-node-host'
let g:python_host_prog='$MAIN_PYTHON2_HOME/bin/python2'
let g:python3_host_prog='$MAIN_PYTHON3_HOME/bin/python3'

set number
set inccommand=nosplit

set splitbelow
set splitright

set expandtab
set shiftwidth=2
set softtabstop=2

set list listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

set cursorline

set undofile
set noshowmode


call plug#begin(stdpath('data') . '/plugged')

Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'

Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}

" Colorscheme
Plug 'drewtempelmeyer/palenight.vim'
let g:palenight_terminal_italics=1

" Statusline
Plug 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'gitbranch' ],
      \             ['readonly', 'filename', 'modified' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename'
      \ }
      \}

function! LightlineFilename()
  return expand('%:f') !=# '' ? expand('%:f') : '[No Name]'
endfunction

Plug 'preservim/tagbar'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" Ruby/Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'rhysd/vim-textobj-ruby'

" Filetypes plugins
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

Plug 'andys8/vim-elm-syntax'

Plug 'posva/vim-vue'

" Test runner
Plug 'janko/vim-test'
let test#strategy="asyncrun"
let test#enabled_runners = ["rust#cargotest", "ruby#rspec"]
nmap <leader>tf :TestFile<CR>
nmap <leader>tn :TestNearest<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>

Plug 'skywind3000/asyncrun.vim'
let g:asyncrun_open = 6
augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

Plug 'tpope/vim-dispatch'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <Tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gw <Plug>(coc-diagnostic-next)
nmap <leader>gW <Plug>(coc-diagnostic-prev)
nmap <leader>ge <Plug>(coc-diagnostic-next-error)
nmap <leader>gE <Plug>(coc-diagnostic-prev-error)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
nmap <leader>fs <Plug>(coc-codeaction-selected)<CR>
nmap <leader>fl <Plug>(coc-codeaction)
nmap <leader>fc <Plug>(coc-fix-current)
nmap <leader>ds <Plug>(coc-diagnostic-info)
nmap <leader>rr <Plug>(coc-refactor)
vmap <leader>rr <Plug>(coc-refactor)
nmap <leader>rn <Plug>(coc-rename)

Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'

Plug 'jlanzarotta/bufexplorer'
Plug 'roman/golden-ratio'
let g:golden_ratio_exclude_nonmodifiable = 1

Plug 'mbbill/undotree'

Plug 'stefandtw/quickfix-reflector.vim'
let g:qf_modifiable = 1
let g:qf_join_changes = 1

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = '~/.local/share/fzf-history'
nmap <c-p> :FZF<CR>

Plug 'junegunn/vim-slash'
Plug 'easymotion/vim-easymotion'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'
let g:AutoPairsFlyMode = 0

Plug 'tpope/vim-endwise'

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level  = 2
let g:indent_guides_guide_size = 1

Plug 'kshenoy/vim-signature'

Plug 'tpope/vim-unimpaired'
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

Plug 'tpope/vim-repeat'

Plug 'kana/vim-textobj-user'
Plug 'wellle/targets.vim'

Plug 'terryma/vim-expand-region'
let g:expand_region_text_objects_ruby = {
      \ 'iw'            :0,
      \ 'i"'            :0,
      \ 'a"'            :0,
      \ 'i'''           :0,
      \ 'a'''           :0,
      \ 'ia'            :1,
      \ 'aa'            :1,
      \ 'i)'            :1,
      \ 'a)'            :1,
      \ 'i]'            :1,
      \ 'a]'            :1,
      \ 'ib'            :1,
      \ 'iB'            :1,
      \ 'il'            :0,
      \ 'ip'            :0,
      \ 'if'            :0,
      \ 'af'            :0,
      \ 'ic'            :0,
      \ 'ac'            :0,
      \ 'ie'            :0,
      \ }

Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'

call plug#end()

if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif


"Colors

set termguicolors
set background=dark
colorscheme palenight

highlight Search     guibg=DarkRed    guifg=LightYellow
highlight IncSearch  guibg=DarkRed    guifg=LightYellow

highlight DiffAdd            guibg=bg         guifg=LightGreen
highlight DiffDelete         guibg=bg         guifg=LightRed
highlight DiffChange         guibg=LightGreen guifg=bg
highlight DiffText           guibg=DarkGreen  guifg=White
highlight CursorColumn       guibg=#444444    guifg=None
highlight CursorLine         guibg=#444444    guifg=None
highlight bufExplorerMapping guibg=#444444    guifg=None


" Mappings

nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

inoremap jk <esc>

" keep selections after indentation

vnoremap > >gv
vnoremap < <gv

" Windows navigation

tnoremap <C-w> <C-\><C-N><C-w>



" Meta

nmap <silent> <leader>me :split $MYVIMRC<CR>
nmap <silent> <leader>ms :source $MYVIMRC<CR>


" Learning

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>


function s:TrimWhitespaces()
  let l = line(".")
  let c = col(".")
  keepp %s/\s\+$//e
  call cursor(l, c)
endfunction

au BufWritePre * :call s:TrimWhitespaces()

" Connect tags file
" Look in current dir first, then up to containing_dir
set tags+=./tags;,tags;

" On writing a file of the following types
au BufWritePost &.c,*.rb,*.js,*.php,*.py silent! ctags &

" Autoread externally modified files (set autoread does not work in terminal
" per https://stackoverflow.com/a/10962191/1645401)
au FocusGained,BufEnter * :checktime
