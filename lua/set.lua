vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- spell
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.spelloptions = 'camel'

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes:2'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.relativenumber = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
-- vim.opt.expandtab = true

vim.o.colorcolumn = '100'

-- vim.o.autoread = true

vim.o.autowrite = true
vim.o.autowriteall = true

vim.o.scrolloff = 8

vim.o.wrap = false

vim.o.splitright = true

vim.o.equalalways = false

vim.o.winblend = 25

-- startify
vim.o.sessionoptions = "globals," .. vim.o.sessionoptions -- To save the sort order for bufferline (:help bufferline)

-- nvimtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- nvim-ufo
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.diagnostic.config({
  severity_sort = true
})

-- vim-wordmotion
-- vim.g.wordmotion_nomap = 1
-- camelCaseWord_test

-- codeium
vim.g.codeium_disable_bindings = 1
