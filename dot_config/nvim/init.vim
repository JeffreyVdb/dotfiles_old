" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

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

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ziglang/zig.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Theming
colorscheme tokyonight
let g:lightline = {'colorscheme': 'tokyonight'}

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
  ensure_installed = { "zig", "bash", "c", "python" },

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
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


set foldlevel=2
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()