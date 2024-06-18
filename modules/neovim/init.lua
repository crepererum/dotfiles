-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- packages
require('lazy').setup({
    -- restore view
    'zhimsel/vim-stay',

    -- color schema
    'savq/melange-nvim',

    -- SudoRead and SudoWrite
    -- TODO: convert to nvim
    'chrisbra/SudoEdit.vim',

    -- language server (autocompletion, warnings/errors)
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-path',
    'ray-x/cmp-treesitter',
    'hrsh7th/nvim-cmp',

    -- autopairs
    'windwp/nvim-autopairs',

    -- snippets
    'L3MON4D3/LuaSnip',

    -- rust
    {
        'mrcjkb/rustaceanvim',
        -- This plugin is already lazy
        lazy = false,
    },
    'nvim-lua/popup.nvim',

    -- status line
    'hoob3rt/lualine.nvim',
    'nvim-lua/lsp-status.nvim',

    -- signatures
    'ray-x/lsp_signature.nvim',

    -- telescope
    'nvim-treesitter/nvim-treesitter',
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            'debugloop/telescope-undo.nvim'
        },
    },

    -- incremental search
    'kevinhwang91/nvim-hlslens',

    -- File Tree
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },

    -- number toggle
    'sitiom/nvim-numbertoggle',

    -- comment toggle
    'numToStr/Comment.nvim',

    -- git sigs / decoration
    'lewis6991/gitsigns.nvim',
})

-- imports
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local comment = require('Comment')
local gitsigns = require('gitsigns')
local hlslens = require('hlslens')
local lualine = require('lualine')
local lsp_signature = require('lsp_signature')
local lsp_status = require('lsp-status')
local nvim_autopairs = require('nvim-autopairs')
local nvim_autopairs_comp = require('nvim-autopairs.completion.cmp')
local nvim_tree = require('nvim-tree')
local nvim_tree_api = require('nvim-tree.api')
local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local telescope_themes = require('telescope.themes');

-- color
vim.opt.termguicolors = true
vim.cmd.colorscheme 'melange'

-- comment toggle
comment.setup({})

-- clipboard
vim.opt.clipboard = 'unnamed'

-- cmp
vim.o.completeopt = 'menu,menuone,noselect'
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

-- gitsigns
gitsigns.setup({})

-- gui
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = {
    tab='~>',
    trail='·',
}
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.scrolloff = 16
vim.opt.sidescrolloff = 10
vim.opt.ttimeoutlen = 0
vim.opt.visualbell = true

-- hlslens
hlslens.setup()
local kopts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)

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
vim.keymap.set('n', '<F10>', nvim_tree_api.tree.toggle, {})

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
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end

local capabilities = vim.tbl_extend('keep', vim.lsp.protocol.make_client_capabilities(), lsp_status.capabilities)
local capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
vim.g.rustaceanvim = {
  -- LSP configuration
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- sessions
vim.opt.viewoptions = 'cursor,folds,slash,unix'

-- shift, tab, indent, backspace
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- spellcheck
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- telescope
telescope.setup({
    extensions = {
        ['ui-select'] = {
            telescope_themes.get_dropdown {}
        },
    },
    undo = {},
})
telescope.load_extension('ui-select')
telescope.load_extension('undo')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>ft', telescope_builtin.builtin, {})
vim.keymap.set('n', '<leader>u', telescope.extensions.undo.undo, {})

-- undo/redo history
vim.opt.undofile = true

-- not migrated yet:
--[[
" neovim fixes
runtime! python_setup.vim

" faster command line commands
nnoremap ! :!

" split and navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

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
function! MyPaste()
    set paste
    normal "+p
    set nopaste
endfunction
nmap <silent> <C-p> :call MyPaste()<CR>
imap <silent> <C-p> <ESC>:call MyPaste()<CR>a
vmap <C-c> "+y

" PreserveNoEOL
" required by editorconfig to handle this specific rule
Plug 'vim-scripts/PreserveNoEOL'

" editorconfig
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'

" GIT commands
Plug 'tpope/vim-fugitive'
Plug 'rhysd/conflict-marker.vim'

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
--]]

-- TODO: check https://github.com/folke/trouble.nvim
