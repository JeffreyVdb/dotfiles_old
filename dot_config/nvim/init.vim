" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

let g:python3_host_prog = $HOME . '/.local/venv/nvim/bin/python'

set nu
set syntax

"""
""" Keyshort shortcuts
"""
imap jj <Esc>

" Move to panes easier
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

call plug#begin()

Plug 'kien/ctrlp.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ziglang/zig.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
Plug 'terrortylor/nvim-comment'


call plug#end()

" Keep undo history across sessions by storing it in a file
let vimDir = '$HOME/.vim'
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir -p' . vimDir)
    call system('mkdir -p' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

lua << EOF
require('nvim_comment').setup()
EOF

" ==============================
" Theming
" ==============================
if has('termguicolors')
    set termguicolors
endif

set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

let g:lightline = {'colorscheme': 'gruvbox_material'}

" Tab settings
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                 " don't expand tabs to spaces by default
set shiftwidth=4                " number of spaces to use for autoindenting
set smarttab
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
filetype plugin on      " use the file type plugins
set ruler

set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set splitbelow
set splitright

"""
""" Tree Sitter configuration
"""
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "zig", "bash", "c", "python", "hcl" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

"""
""" COC stuff
"""
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

set foldlevel=2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
