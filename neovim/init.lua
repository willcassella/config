vim.opt.modeline = false -- Modelines are insecure
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
vim.opt.diffopt:append{ 'vertical' } -- Always use vertical splits for diff
vim.opt.number = true -- Show line number on current line
vim.opt.wrap = false -- Wrapping is annoying
vim.opt.showmatch = true -- Show matching brackets
vim.opt.matchtime = 1 -- Cursor restores after highlighting matching bracket in 0.1 seconds
vim.opt.matchpairs:append{ '<:>' } -- Enable matching between < and >
vim.opt.signcolumn = "yes" -- Always show the side column
vim.opt.list = true
vim.opt.listchars = { trail = '~', tab = '>-' }
vim.opt.completeopt:remove{ 'preview' }
vim.opt.completeopt:append{ 'menuone' }
vim.opt.cursorline = true -- Highlight cursor line

-- Increase history limit
vim.opt.shada = "!,'1000,<50,s10,h"

-- Make cursorline only work on active window
vim.api.nvim_create_autocmd({'WinEnter', 'WinLeave'}, {
    nested = true,
    callback = function(e)
        if e.event == 'WinEnter' then
            vim.opt_local.cursorline = true
        else
            vim.opt_local.cursorline = false
        end
    end
})

-- Set terminal style options
vim.api.nvim_create_autocmd('TermOpen', {
    nested = true,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.signcolumn = 'no'
    end
})

-- Make command mode have emacs-style keybindings.
-- <C-E> already works.
vim.keymap.set('c', '<C-A>', '<Home>')
vim.keymap.set('c', '<C-F>', '<Right>')
vim.keymap.set('c', '<C-B>', '<Left>')
vim.keymap.set('c', '<m-b>', '<S-Left>')
vim.keymap.set('c', '<m-f>', '<S-Right>')

-- Autoformat options for markdown files
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    nested = true,
    command = 'setl spell tw=120 fo+=aw fo-=c'
})
