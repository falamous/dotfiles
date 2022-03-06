syntax on

set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set matchpairs+=<:>     " Match tag pairs
set expandtab           " Insert spaces when TAB is pressed.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
if !&scrolloff
	set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
	set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

set mouse=nvi            " Actually use the mouse
set nostartofline        " Do not jump to first character with page commands.
set ignorecase           " Make searching case insensitive
set smartcase            " ... unless the query has capital letters.
set gdefault             " Use 'g' flag by default with :s/foo/bar/.
" set nowrap
" set nohlsearch           " Don't highlight search results


" allow russian keys in normal mode
set langmap+=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set langmap+=Ёё;~`
set langmap+=хъжэбю;[]\\;'\\,.
set langmap+=ХЪЖЭБЮ;{}:\\"<>


" set langmap+=хъ\\жэбю.;[]\\\;'\,./'
" set langmap+=ХЪ/ЖЭБЮ\,;{}\|:\"<>?
nmap <Leader>s :%s///<Left><Left>

" Don't cancel the visual block after indenting
vmap < <gv
vmap > >gv


" Use <C-L> to clear the highlighting of :set hlsearch.
" if maparg('<C-H>', 'n') ==# ''
"   nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
" endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif

" Save undo history.
set undofile
" set undodir=stdpath('cache') . '/undo'

call plug#begin(stdpath('data') . '/plugged')
" Plug 'preservim/nerdtree'                            " file management, that I don't use
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern.vim'                          " file management

Plug 'antoinemadec/FixCursorHold.nvim'               " fern fix
Plug 'rootkiter/vim-hexedit'                         " hex editor
Plug 'tpope/vim-surround'                            " surround motion
Plug 'easymotion/vim-easymotion'                     " easy motion
Plug 'ap/vim-css-color'                              " color highlighting
" Plug 'justinmk/vim-sneak'                          " sneak motion
" Plug 'chrisbra/Colorizer'                          " color highlighting
" Plug 'rlue/vim-barbaric'                           " automaticly switch to english upon leaving insert mode and back to russian when entering it
Plug 'mg979/vim-visual-multi'                        " multi-cursor
Plug 'tpope/vim-commentary'                          " comment command
Plug 'vim-airline/vim-airline'                       " airline bar
Plug 'jeetsukumaran/vim-pythonsense'                 " various python motions
Plug 'petRUShka/vim-sage'                            " sage syntax highlighting
Plug 'udalov/kotlin-vim'                             " kotlin syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}      " auto completetion and syntax checks
" Plug 'vim-syntastic/syntastic'                     " syntax checks
Plug 'jackguo380/vim-lsp-cxx-highlight'              " better syntax highlighting
Plug 'habamax/vim-godot'
" Plug 'fatih/vim-go'                                  " go stuff


Plug 'cocopon/iceberg.vim'
Plug 'sts10/vim-pink-moon'
Plug 'AlessandroYorba/Alduin'
Plug 'haystackandroid/carbonized'
Plug 'whatyouhide/vim-gotham'
Plug 'andreasvc/vim-256noir'
Plug 'rakr/vim-two-firewatch'

" Coc extensions
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/fannheyward/coc-texlab', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
call plug#end()


" Netrw configuration
" let g:netrw_liststyle = 3
" let g:netrw_banner = 0

" let g:netrw_browse_split = 4
" let g:netrw_winsize = 10
" let g:netrw_special_syntax = 1
" let g:netrw_keepdir = 0
" let g:netrw_localcopydircmd = 'cp -r'
"
let g:fern#default_hidden = 1
let g:fern#renderer = "nerdfont"
function SetupFern()
    Fern . -drawer
endfunction
cnoreabbrev vx call SetupFern()


let $ZSH_DONT_USE_VI_MODE="kek"
function SetupTerm()
    8sp term://zsh
endfunction
cnoreabbrev tt call SetupTerm()

function SetupIde()
    call SetupTerm()
    call SetupFern()
endfunction
cnoreabbrev ide call SetupIde()


source ~/.config/nvim/coc.vim
" source ~/.config/nvim/syntastic.vim
"
if has("nvim-0.5.0")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

command W execute "w"
command Wq execute "wq"
command WQ execute "wq"
command Q execute "q"

cnoreabbrev hex2c Hex2C
cnoreabbrev hc Hex2C
cnoreabbrev hex2py Hex2Py
cnoreabbrev hpy Hex2Py
cnoreabbrev hexload HexLoad
cnoreabbrev hl HexLoad
cnoreabbrev hexedit Hexedit
cnoreabbrev he Hexedit
cnoreabbrev hexkeep Hexkeep
cnoreabbrev hk Hexkeep
cnoreabbrev hexplore Hexplore
cnoreabbrev he Hexplore
cnoreabbrev hexsearch Hexsearch
cnoreabbrev hs Hexsearch

" autocmd InsertEnter * silent !caps on &
" autocmd InsertLeave * silent !caps off &
" autocmd UIEnter * silent !caps off &
" autocmd UILeave * silent !caps off &

" tabulation settings
set tabstop=4
set shiftwidth=4
autocmd FileType python set tabstop=8|set shiftwidth=4
autocmd FileType c set tabstop=8|set shiftwidth=8
autocmd FileType ruby set tabstop=8|set shiftwidth=4
autocmd FileType yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType nroff set noexpandtab

set termguicolors
" theme

" error highlighting
hi CocErrorHighlight ctermfg=red  guifg=red cterm=underline gui=underline
hi Error ctermfg=red  guifg=red cterm=underline gui=underline

" colorscheme iceberg
" set background=dark
colorscheme two-firewatch
let g:airline_theme='iceberg'

hi MatchParen gui=reverse cterm=reverse
hi Normal guibg=None ctermbg=None
