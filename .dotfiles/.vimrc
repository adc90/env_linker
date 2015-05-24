"-------------------------------------"
" adc90's vim configuration
"-------------------------------------"

"-------------------------------------"
" Standard vim settings
"-------------------------------------"
set ttymouse=xterm2
set hidden
set hlsearch
set ignorecase
set incsearch
set magic
set number
set showmatch
set smartcase
set mouse=a
set backspace=indent,eol,start
syntax sync minlines=256

"Customize the characters for new line and tab
set listchars=tab:▸\ ,eol:·

"Tab configuration
set shiftwidth=4
set expandtab
set softtabstop=4

if has("syntax")
    syntax on
endif

"Set backup directories
set nobackup
set nowb
set noswapfile

"Auto-commands
if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    endif
endif

hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END
hi CursorLineNR cterm=bold
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

au InsertLeave *.css :BLReloadCSS
au InsertLeave *.html :echo "hi"
"-------------------------------------"


"--------------------------------------------"
" Set Vundle stuff
"--------------------------------------------"
if !1 | finish | endif

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

"--------------------------------------------"
" Plugins
"--------------------------------------------"
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \ 'windows' : 'tools\\update-dll-mingw',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
            \ },
            \ }
NeoBundle 'whatyouhide/vim-gotham'
NeoBundle 'jaxbot/browserlink.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'MattesGroeger/vim-bookmarks'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ZoomWin'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'ap/vim-css-color'
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'docunext/closetag.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'ervandew/supertab'
NeoBundle 'godlygeek/csapprox'
NeoBundle 'godlygeek/tabular'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'junegunn/limelight.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'nice/sweater'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'othree/html5.vim'
NeoBundle 'rdlugosz/vim-dragvisuals'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-capslock'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'triglav/vim-visual-increment'
NeoBundle 'vim-coffee-script'
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'vim-scripts/CycleColor'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'vim-scripts/cascadia.vim'
NeoBundle 'vimwiki/vimwiki'
NeoBundle 'kopischke/unite-spell-suggest'
NeoBundle 'kristijanhusak/vim-multiple-cursors'
NeoBundle 'Yggdroot/indentLine'
"--------------------------------------------"

call neobundle#end()
filetype plugin indent on

NeoBundleCheck

"--------------------------------------------"
"" Plugin configurations
"--------------------------------------------"
""Vim-airline configuration
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled =1

set laststatus=2

let g:airline_theme = "badwolf"

"Bookmarks
"let g:bookmark_save_per_working_dir = 1

"Nerd Tree toggle
let g:NERDTreeWinPos = "left"
let g:tagbar_left = 0

"Incremental increase of alpha characters
set nrformats=alpha

"CSS color preview
let g:cssColorVimDoNotMessMyUpdatetime = 1

"Neocomplete configuration
let g:acp_enableAtStartup = 0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"

"Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

"Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
let g:unite_source_history_yank_enable = 1

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
    endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
    endif
endfunction

"Indent line
let g:indentLine_char = '︙'

"Syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_full_redraws = 1
let g:syntastic_auto_jump = 2
let g:syntastic_auto_loc_list = 1
"--------------------------------------------"

"--------------------------------------------"
" Map leader
"--------------------------------------------"
"Set leader to space
let mapleader=" "
"Set leader bar short cuts
map <leader>b :call ToggleSyntax()            <CR>
map <leader>g :YRShow                         <CR>
map <leader>c :setlocal spell!                <CR>
map <leader>d :call ToggleLimeLight()         <CR>
map <leader>f :Unite grep:.                   <CR>
map <leader>g :Unite history/yank             <CR>
map <leader>j i                               <CR> <Esc>
map <leader>k :Unite -quick-match buffer      <CR>
map <leader>l :set list!                      <CR>
map <leader>o :NERDTreeToggle                 <CR>
map <leader>p :call StripTrailingWhitespace() <CR>
map <leader>r :call ToggleNumber()            <CR>
map <leader>s :w                              <CR>
map <leader>t :TagbarToggle                   <CR>
map <leader>u :GundoToggle                    <CR>
map <leader>y :call ShowColumn()              <CR>
map <leader>a :call ToggleLimeLight()         <CR>
"--------------------------------------------"

"--------------------------------------------"
" Regular key remapings
"--------------------------------------------"
"Remap a H,D,L to behave more normally
noremap H ^
nnoremap D d$
noremap L $
vnoremap L g_
"Map C-e to eol for insert mode
"Map C-a to bol for insert mode
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
"----------------------------------"

"----------------------------------"
" Resizing the vim buffers using
" ctrl + [hjkl]
" eventually I would like to replace
" this with the arrow keys and use
" control + [hjkl] to move lines
"----------------------------------"
noremap <C-K> :resize -5<CR>
noremap <C-J> :resize +5<CR>
noremap <C-L> :vertical resize +5<CR>
noremap <C-H> :vertical resize -5<CR>
"----------------------------------"

"----------------------------------"
" Some functions I've picked up and
" wrote myself
"----------------------------------"

"Toggle relative numbers: http://dougblack.io/words/a-good-vimrc.html#colors
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

function! ShowColumn()
    if(&colorcolumn != 0)
        set colorcolumn=0
    else
        highlight ColorColumn ctermbg=red
        set colorcolumn=81
    endif
endfunction

function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<CR>
        normal `z
    endif
endfunction

function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction

function! ToggleLimeLight()
    Limelight!!
endfunction
"-------------------------------------"

"-------------------------------------"
" Colorscheme stuff
"-------------------------------------"
color Mustang
highlight NonText guifg=fg guibg=bg ctermfg=fg ctermbg=bg gui=none cterm=none
set t_Co=256
"-------------------------------------"

