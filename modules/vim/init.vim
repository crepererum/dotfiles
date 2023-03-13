" general vim setup
set fileencoding=utf-8
set lazyredraw
set mouse=a

" neovim fixes
runtime! python_setup.vim

" undo/redo history
set history=100
silent !mkdir ~/.vim/undo > /dev/null 2>&1
set undodir=~/.vim/undo
set undofile

" shift, tab, indent, backspace
set backspace=indent,eol,start
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" faster command line commands
nnoremap ! :!

" split and navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" better search
set incsearch
set ignorecase
set smartcase
set wrapscan

" look and feel
syntax enable
set number
set ruler
set showcmd
set list listchars=tab:→\ ,trail:·
set scrolloff=16
set sidescrolloff=10
set tabpagemax=32
set cursorline
set ttimeoutlen=0
set noerrorbells
set visualbell
set t_vb =

" bigger syntax scan range
autocmd BufEnter * :syntax sync minlines=500

" wildmenu
set wildmenu
set wildmode=list:longest,full

" ignores
set wildignore+=*.pyc

" folds
" set foldmethod=syntax
" set foldopen=block,hor,jump,mark,percent,quickfix,search,tag,undo
nmap <SPACE> za

" strip whitespaces @ safe (except diff files)
autocmd BufWritePre *
    \ if &filetype != "diff"
    \ | :%s/\s\+$//e
    \ | endif

" fix markdown editing
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" figure out the system Python for Neovim
function GetWhichFirst(programs)
    let l:candidate=''
    for p in a:programs
        let l:candidate=substitute(system("which " . p), "\n", '', 'g')
        if l:candidate != ''
            break
        endif
    endfor
    return l:candidate
endfunction
function GetWhichSecond(programs)
    let l:candidate=''
    for p in a:programs
        let l:candidate=substitute(system("which -a " . p . " | head -n2 | tail -n1"), "\n", '', 'g')
        if l:candidate != ''
            break
        endif
    endfor
    return l:candidate
endfunction
let s:candidates_python2=['python2.7', 'python2']
let s:candidates_python3=['python3.10', 'python3.9', 'python3.8', 'python3.7', 'python3.6', 'python3']
if exists("$VIRTUAL_ENV") || exists("$CONDA_PREFIX")
    let g:python_host_prog=GetWhichSecond(s:candidates_python2)
    let g:python3_host_prog=GetWhichSecond(s:candidates_python3)
else
    let g:python_host_prog=GetWhichFirst(s:candidates_python2)
    let g:python3_host_prog=GetWhichFirst(s:candidates_python3)
endif

" clipboard
set clipboard=unnamed
function! MyPaste()
    set paste
    normal "+p
    set nopaste
endfunction
nmap <silent> <C-p> :call MyPaste()<CR>
imap <silent> <C-p> <ESC>:call MyPaste()<CR>a
vmap <C-c> "+y

" vim-plug
call plug#begin('~/.local/share/neovim/plugged')
filetype off
Plug 'junegunn/vim-plug'

" restore view
Plug 'zhimsel/vim-stay'
set viewoptions=cursor,folds,slash,unix

" color schema
Plug 'savq/melange'

" SudoRead and SudoWrite
Plug 'chrisbra/SudoEdit.vim'

" Pencil
Plug 'reedes/vim-pencil'

" fzf
Plug 'junegunn/fzf'

" language server (autocompletion, warnings/errors)
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/cmp-treesitter'
Plug 'hrsh7th/nvim-cmp'

Plug 'windwp/nvim-autopairs'

" snippets
Plug 'L3MON4D3/LuaSnip'

" rust
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/popup.nvim'

" status line
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-lua/lsp-status.nvim'

" signatures
Plug 'ray-x/lsp_signature.nvim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" PreserveNoEOL
" required by editorconfig to handle this specific rule
Plug 'vim-scripts/PreserveNoEOL'

" editorconfig
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" VCS diffs
Plug 'mhinz/vim-signify'

" GIT commands
Plug 'tpope/vim-fugitive'
Plug 'rhysd/conflict-marker.vim'

" tcomment
Plug 'tomtom/tcomment_vim'

" startify
Plug 'mhinz/vim-startify'
hi StartifyBracket ctermfg=240
hi StartifyFooter  ctermfg=111
hi StartifyHeader  ctermfg=203
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240

" shebang filetype detection
Plug 'vitalk/vim-shebang'

" julia
Plug 'JuliaLang/julia-vim'
let g:julia_latex_to_unicode = 0

" rust
Plug 'rust-lang/rust.vim'

" numbertoggle
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" CTRL-P
Plug 'ctrlpvim/ctrlp.vim'

" Ripgrep
Plug 'jremmen/vim-ripgrep'

" EasyMotion
Plug 'Lokaltog/vim-easymotion'

" distraction-free writing
" goyo and limelight
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
function! GoyoBefore()
    set nocursorline
    set wrap
    set linebreak
    set nolist
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
endfunction

function! GoyoAfter()
    Limelight!
    set list
    set nolinebreak
    set nowrap
    set cursorline
    set showmode
    set showcmd
    set scrolloff=8
endfunction

let g:goyo_width = 120
let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]

" more text object
Plug 'vim-scripts/argtextobj.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'michaeljsmith/vim-indent-object'

" expand region
Plug 'terryma/vim-expand-region'

" incremental search
Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map <silent> <F8> :nohlsearch<CR>

" exchange
Plug 'tommcdo/vim-exchange'

" NrrwRgn
Plug 'chrisbra/NrrwRgn'

" better diff
Plug 'chrisbra/vim-diff-enhanced'

" sneak
Plug 'justinmk/vim-sneak'

" better Python indention
Plug 'Vimjas/vim-python-pep8-indent'

" undo-redo tree
Plug 'simnalamburt/vim-mundo'
nnoremap <silent> <F5> :MundoToggle<CR>

" File Tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
nnoremap <silent> <F10> :NvimTreeToggle<CR>

" startup time
Plug 'dstein64/vim-startuptime'

" matchit
runtime! macros/matchit.vim

" spell check
autocmd BufWinEnter * let b:myLang=0
let g:myLangList=["nospell","de_de","en_us","es"]
function! ToggleSpell()
    let b:myLang=b:myLang+1
    if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
        setlocal nospell
    else
        execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
    endif
    echo "spell checking language:" g:myLangList[b:myLang]
endfunction
nmap <silent> <F7> :call ToggleSpell()<CR>
imap <silent> <F7> <ESC>:call ToggleSpell()<CR>a

" highlight overlong lines
" HINT: needs to go at the very bottom of the file
let &colorcolumn=join(range(121,999),",")

" activate filetype again
call plug#end()
filetype plugin indent on

" color goes last for some reason
set termguicolors
colorscheme melange

" lua stuff
lua << EOF
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lualine = require('lualine')
local lsp_signature = require('lsp_signature')
local lsp_status = require('lsp-status')
local nvim_autopairs = require('nvim-autopairs')
local nvim_autopairs_comp = require('nvim-autopairs.completion.cmp')
local nvim_tree = require('nvim-tree')
local rust_tools = require('rust-tools')
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local telescope_themes = require("telescope.themes");


-- cmp
vim.o.completeopt = "menu,menuone,noselect"
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
        },
        {
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'calc' },
            { name = 'treesitter' },
        }
    ),
})


-- lualine
local function lualine_c()
    return lsp_status.status()
end
lualine.setup({
    options = {
        theme = 'onedark',
    },
    sections = {
        lualine_b = {
            'branch',
            {
                'filename',
                path = 1,
            },
        },
        lualine_c = { lualine_c },
    },
})


-- lsp_signature
lsp_signature.setup()


-- lsp-status
lsp_status.register_progress()


-- nvim-autopais
nvim_autopairs.setup()
cmp.event:on( 'confirm_done', nvim_autopairs_comp.on_confirm_done({  map_char = { tex = '' } }))


-- nvim-tree
nvim_tree.setup({
    update_focused_file = {
        enable = true,
    },
})


-- rust-tools
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    lsp_status.on_attach(client, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>d', telescope_builtin.diagnostics, bufopts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local capabilities = vim.tbl_extend('keep', vim.lsp.protocol.make_client_capabilities(), lsp_status.capabilities)
local capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
rust_tools.setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
})


-- telescope
telescope.setup({
    extensions = {
        ["ui-select"] = {
            telescope_themes.get_dropdown {}
        },
    },
})
telescope.load_extension('ui-select')
EOF
