vim.opt.expandtab = true -- Tab expands to spaces
vim.opt.tabstop = 4 -- Tabs are 4 spaces
vim.opt.shiftwidth = 4 -- Indenting (< and >) is done in 4 space increments
vim.opt.ignorecase = true -- Searching is case-insensitive
vim.opt.smartcase = true -- unless the query has a capital letter
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.sidescrolloff = 5
vim.opt.updatetime = 300
vim.opt.diffopt:append{'vertical'} -- Always use vertical splits for diff
vim.opt.number = true -- Show line number on current line
vim.opt.wrap = false -- Wrapping is annoying
vim.opt.linebreak = true -- Use line breaking when wrapping is enabled
vim.opt.showmatch = true -- Show matching brackets
vim.opt.matchtime = 1 -- Cursor restores after highlighting matching bracket in 0.1 seconds
vim.opt.matchpairs:append{'<:>'} -- Enable matching between < and >
vim.opt.signcolumn = "yes" -- Always show the side column
vim.opt.list = true
vim.opt.listchars = {trail = '~', tab = '>-'}
vim.opt.completeopt:remove{'preview'}
vim.opt.completeopt:append{'menuone'}
vim.opt.cursorline = true -- Highlight cursor line

-- Increase history limit
vim.opt.shada = "!,'1000,<50,s10,h"

-- Use ripgrep (with smart case and vcs ignore) as the grep provider
if vim.fn.executable('rg') then
    vim.opt.grepprg = 'rg --vimgrep --smart-case'
end

-- Make cursorline only work on active window
vim.api.nvim_create_autocmd({'WinEnter', 'WinLeave'}, {
    nested = true,
    callback = function(e)
        if e.event == 'WinEnter' then
            vim.opt_local.cursorline = true
        else
            vim.opt_local.cursorline = false
        end
    end,
})

-- Autoformat options for markdown files
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    nested = true,
    command = 'setl spell tw=120 fo+=aw fo-=c',
})

-- Add more filetypes
vim.filetype.add{
    extension = {
        envrc = 'bash',
        hlsl = 'hlsl',
    },
}

-- Use space as leader key
vim.g.mapleader = ' '

-- Make command mode have emacs-style keybindings.
-- <C-E> already works.
vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('c', '<c-f>', '<right>')
vim.keymap.set('c', '<c-b>', '<left>')
vim.keymap.set('c', '<m-b>', '<s-left>')
vim.keymap.set('c', '<m-f>', '<s-right>')

-- Useful for quickly opening another file in the current directory
vim.keymap.set('ca', '%%', function() return vim.fn.expand('%:h') end, {expr = true})

-- Statusline
status_line_parts = {
    left = {
    },
    right = {'%{&fenc}', '%{&ff}', '%{&ft}'},
}

local function eval_status_line_parts(parts)
    return vim.iter(parts)
        :map(function(part)
            return {'%( | ', part, '%)'}
        end)
        :totable()
end

function status_line()
    local left_base = '%t%( %m%r%)'
    local right_base = '%l/%L:%c #%{winnr()}'
    local left_parts = status_line_parts.left
    local right_parts = status_line_parts.right

    if vim.bo.buftype == 'terminal' then
        -- Style terminal buffers differently
        left_base = '%t [%{b:term_title}]'
        left_parts = {}
        right_parts = {'term'}
    end

    if tostring(vim.fn.win_getid()) == vim.g.actual_curwin then
        left_parts = eval_status_line_parts(left_parts)
        right_parts = eval_status_line_parts(right_parts)
    else
        -- Hide parts in inactive windows.
        left_parts = {}
        right_parts = {}
    end

    return vim.iter({' ', left_base, '%<', left_parts, '%=', right_base, right_parts, ' '})
        :flatten(math.huge)
        :join()
end
vim.opt.statusline = '%{%v:lua.status_line()%}'

if vim.g.load_plugins == 1 then
    vim.cmd([[
        call plug#begin()
        Plug 'airblade/vim-gitgutter'
        Plug 'foosoft/vim-argwrap'
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'junegunn/vim-plug'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-repeat'
        Plug 'tpope/vim-surround'
        Plug 'wellle/targets.vim'
        Plug 'willcassella/nvim-gn'
        Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main'}
        Plug 'Mofiqul/vscode.nvim'
        Plug 'rebelot/kanagawa.nvim'
        call plug#end()
    ]])

    -- vim-fugitive
    table.insert(status_line_parts.left, '%{FugitiveHead()}')

    -- nvim-treesitter
    require('nvim-treesitter').setup{highlight = {enable = true}}

    -- fzf.vim
    vim.keymap.set('n', '<leader>f', '<cmd>Files<cr>', {silent = true})
    vim.keymap.set('n', '<leader>d', '<cmd>Buffers<cr>', {silent = true})
    vim.keymap.set('n', '<leader>g', '<cmd>History<cr>', {silent = true})

    -- vim-argwrap
    vim.keymap.set('n', '<leader>*', '<cmd>ArgWrap<cr>', {silent = true})

    -- coc.nvim
    table.insert(status_line_parts.left, '%{coc#status()}')
    vim.api.nvim_create_autocmd('User', {
        pattern = 'CocStatusChange,CocDiagnosticChange',
        nested = true,
        command = 'redrawstatus',
    })
    vim.keymap.set('n', '[e', '<plug>(coc-diagnostic-prev)', {remap = true, silent = true})
    vim.keymap.set('n', ']e', '<plug>(coc-diagnostic-next)', {remap = true, silent = true})
    vim.keymap.set('n', 'gd', '<plug>(coc-definition)', {remap = true, silent = true})
    vim.keymap.set('n', 'gr', '<plug>(coc-references)', {remap = true, silent = true})
    vim.keymap.set('n', 'gh', "<cmd>call CocAction('doHover')<cr>", {silent = true})
    vim.keymap.set('n', '<leader>cf', "<cmd>call CocAction('doQuickfix')<cr>", {silent = true})
    vim.keymap.set('n', '<c-s>', '<cmd>CocList symbols<cr>')
    vim.keymap.set('n', '<c-space>', '<cmd>CocList outline<cr>')

    -- vim-gitgutter
    vim.g.gitgutter_sign_priority = 5
    vim.g.gitgutter_sign_added = '┃'
    vim.g.gitgutter_sign_modified = '╏'
    vim.g.gitgutter_sign_modified_removed = '╏'
    vim.g.gitgutter_sign_removed = '┇'
end

-- Load project vimrc files (no-op if not defined)
-- I prefer this over 'use vim' in .envrc since it's more predictable
-- (run once, unconditionally).
for file in vim.gsplit(vim.env.PROJECT_VIMRC or '', ':') do
    if string.len(file) ~= 0 then
        if vim.endswith(file, '.lua') then
            vim.cmd.luafile(file)
        else
            vim.cmd.source(file)
        end
    end
end
