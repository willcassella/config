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

-- Set terminal style options
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.signcolumn = 'no'
        vim.opt_local.matchpairs = ''
    end
})
