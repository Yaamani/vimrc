--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'onsails/lspkind.nvim',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',          opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      require("scrollbar.handlers.gitsigns").setup()
    end
  },

  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'onedark'
    end,
  },

  { -- Theme
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_style = 'atlantis'
      -- vim.cmd.colorscheme 'sonokai'
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      -- vim.cmd.colorscheme 'catppuccin'
    end
  },

  { -- vscode theme
    'Mofiqul/vscode.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'vscode'
    end,
    commit = 'db9ee339b5556aa832ca58871fd18f9467a18520'
  },

  {
    'folke/tokyonight.nvim'
  },



  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  -- { import = 'custom.plugins' },

  'ThePrimeagen/vim-be-good',

  'nvim-tree/nvim-web-devicons',

  {
    'prettier/vim-prettier',
    build = 'yarn install --frozen-lockfile --production',
  },

  'Pocco81/auto-save.nvim',

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },

  {
    'akinsho/bufferline.nvim',
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  },

  { 'karb94/neoscroll.nvim' },

  {
    'petertriho/nvim-scrollbar',
    config = function()
    end
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      -- require('hlslens').setup() is not required
      require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
      })
    end,
  },

  'mhinz/vim-startify',

  'RRethy/vim-illuminate',

  'jiangmiao/auto-pairs',

  'ray-x/lsp_signature.nvim',

  'JoosepAlviste/nvim-ts-context-commentstring',
  { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },

  'christoomey/vim-tmux-navigator',

  { "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.equalalways = false
      require('windows').setup({
        autowidth = { enable = false },
        animation = {
          enable = true,
          duration = 150,
          fps = 60,
          easing = "in_out_sine"
        }
      })
    end
  },

  'aspeddro/gitui.nvim',

  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  
  'uga-rosa/ccc.nvim', -- color picker/colorizer

}, {})

local vsc = require('vscode.colors').get_colors()
require('vscode').setup({
  -- transparent = true,
  group_overrides = {
    -- this supports the same val table as vim.api.nvim_set_hl
    -- use colors from this colorscheme by requiring vscode.colors!
    ['@variable.builtin'] = { fg = vsc.vscBlue, bg = vsc.vscNone }
  }
})

require 'lualine'.setup {
  options = {
    icons_enabled = false,
    -- theme = 'onedark',
    theme = 'vscode',
    -- theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
}

require("nvim-tree").setup({
  view = {
    preserve_window_proportions = true,
  },
  git = {
    enable = true,
    ignore = false,
  }
})

require("scrollbar").setup({
  handle = {
    color = vsc.vscSplitDark
  },
  marks = {
    Search = { color = vsc.vscOrange }
  },
  handlers = {
    cursor = false
  },
})

require('neoscroll').setup({
  -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', --[['<C-y>', '<C-e>',--]] 'zt', 'zz', 'zb'},
})
local t    = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '50' } }
t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '50' } }
t['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '100' } }
t['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '100' } }
t['<C-y>'] = { 'scroll', { '-0.2', 'false', '25' } }
t['<C-e>'] = { 'scroll', { '0.2', 'false', '25' } }
t['zt']    = { 'zt', { '50' } }
t['zz']    = { 'zz', { '50' } }
t['zb']    = { 'zb', { '50' } }
require('neoscroll.config').set_mappings(t)


require "lsp_signature".setup({})


require("bufferline").setup({
  options = {
    tab_size = 5,
    truncate_names = false, -- whether or not tab names should be truncated
    -- separator_style = 'thick',
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    buffer_close_icon = "",
    close_command = "bdelete %d",
    close_icon = "",
    indicator = {
      style = "icon",
      icon = " ",
    },
    left_trunc_marker = "",
    modified_icon = "●",
    offsets = { { filetype = "NvimTree", text = "File explorer", text_align = "left" } },
    right_mouse_command = "bdelete! %d",
    right_trunc_marker = "",
    show_close_icon = false,
    show_tab_indicators = true,
  },
  highlights = {
    fill = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLineNC" },
    },
    background = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLine" },
    },
    buffer_visible = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    buffer_selected = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    separator = {
      fg = { attribute = "bg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLine" },
    },
    separator_selected = {
      fg = { attribute = "fg", highlight = "Special" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    separator_visible = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLineNC" },
    },
    close_button = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "StatusLine" },
    },
    close_button_selected = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    close_button_visible = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
  },
})

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})

require("gitui").setup()

require('ccc').setup({
  highlighter = {
    auto_enable = true,
  },
})




vim.diagnostic.config({
  severity_sort = true
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
-- vim.o.hlsearch = false

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

vim.o.colorcolumn = '100'

vim.o.autowrite = true
vim.o.autowriteall = true

vim.o.scrolloff = 8

vim.o.wrap = false

vim.o.splitright = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.equalalways = false

vim.o.sessionoptions = vim.o.sessionoptions .. ",globals"

-- vim.cmd[[colorscheme tokyonight]]
-- vim.cmd [[colorscheme vscode]]

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "PmenuSbar" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "PmenuSbar" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "PmenuSbar" })

-- nvim-ufo
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- vim.g.startify_change_to_dir = 0
vim.g.startify_session_persistence = 1

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


vim.keymap.set('n', --[[<A-h>]] '˙', ':BufferLineCyclePrev<cr>', { noremap = true })
vim.keymap.set('n', --[[<A-l>]] '¬', ':BufferLineCycleNext<cr>', { noremap = true })
vim.keymap.set('n', '<A-left>', ':BufferLineMovePrev<cr>', { noremap = true })
vim.keymap.set('n', '<A-right>', ':BufferLineMoveNext<cr>', { noremap = true })


vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, desc = ':NvimTreeToggle' })


-- vim.keymap.set('n', --[['<A-l>']] '¬', '<C-w>l', { noremap = true })
-- vim.keymap.set('n', --[['<A-k>']] '˚', '<C-w>k', { noremap = true })
-- vim.keymap.set('n', --[['<A-j>']] '∆', '<C-w>j', { noremap = true })
-- vim.keymap.set('n', --[['<A-h>']] '˙', '<C-w>h', { noremap = true })


vim.keymap.set('n', --[[ '<A-q>' ]] 'œ', ':BufferLineCyclePrev<CR>:bd! #<CR>')


vim.keymap.set('n', --[[<A-t>t]] '†t', ':term<CR>')
vim.keymap.set('n', --[[<A-t>j]] '†j', ':bel split +term<CR>')
vim.keymap.set('n', --[[<A-t>k]] '†k', ':split +term<CR>')
vim.keymap.set('n', --[[<A-t>l]] '†l', ':vsplit +term<CR>')
vim.keymap.set('n', --[[<A-t>h]] '†h', ':lefta vsplit +term<CR>')

-- vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true})
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true})

vim.keymap.set({ 'n', 'v', 'o' }, 'L', '$', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'H', function()
  local cursor_column_position = vim.api.nvim_win_get_cursor(0)[2]
  local index_of_first_non_space_char = string.find(vim.api.nvim_get_current_line(), "%S")
  if index_of_first_non_space_char == nil then return '^' end
  if cursor_column_position < index_of_first_non_space_char then return '0' else return '^' end
end, { noremap = true, expr = true })

vim.keymap.set('v', '//', 'y/<C-R>=substitute(escape(@", \'/\\.*$^~[\'), \'\\_s\\+\', \'\\\\_s\\\\+\', \'g\')<CR><CR>N',
  { noremap = true })
vim.keymap.set('v', '/c',
  'y/\\C<C-R>=substitute(escape(@", \'/\\.*$^~[\'), \'\\_s\\+\', \'\\\\_s\\\\+\', \'g\')<CR><CR>Ncgn', { noremap = true })

vim.keymap.set('n', --[['<A-j>']] '∆', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', --[['<A-k>']] '˚', ':m .-2<CR>==', { noremap = true })
vim.keymap.set('v', --[['<A-j>']] '∆', ':m \'>+1<CR>gv=gv', { noremap = true })
vim.keymap.set('v', --[['<A-k>']] '˚', ':m \'<-2<CR>gv=gv', { noremap = true })

vim.keymap.set('n', '<C-w>m', ':WindowsMaximize<CR>')
vim.keymap.set('n', '<C-w>_', ':WindowsMaximizeVertically<CR>')
vim.keymap.set('n', '<C-w>|', ':WindowsMaximizeHorizontally<CR>')
vim.keymap.set('n', '<C-w>=', ':WindowsEqualize<CR>')

vim.keymap.set('n', 'git', require("gitui").open, { desc = 'gitui' })
vim.keymap.set('n', 'gib', ':Gitsigns blame_line<CR>')
vim.keymap.set('n', 'giB', ':Gitsigns toggle_current_line_blame<CR>')
vim.keymap.set('n', 'dvc', ':DiffviewClose<CR>')
vim.keymap.set('n', 'dvo', ':DiffviewOpen<CR>')
vim.keymap.set('n', 'dvh', ':DiffviewFileHistory %<CR>')
vim.keymap.set('n', 'dvH', ':DiffviewFileHistory<CR>')

vim.keymap.set('n', '<tab>', 'i<tab>', { noremap = true });


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules", "build", "dist", "yarn.lock"
    },
    mappings = {
      i = {
        -- ["<cr>"] = function(bufnr)
        --   require("telescope.actions.set").edit(bufnr, "tab drop")
        -- end,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- vim.keymap.set('n', '<leader>sf', function() return require('telescope.builtin').find_files({ search_dirs={".", ".."} }) end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sf', function() return require('telescope.builtin').find_files({ hidden = true }) end,
  { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'javascript', 'tsx', 'typescript', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { --[['python'--]] } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    }
  },
}


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local map = function(modes, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(modes, keys, func, { buffer = bufnr, desc = desc })
  end

  map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  map('n', '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  map('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  map({ 'n', 'i' }, --[['<A-K>']] '', function() require('lsp_signature').toggle_float_win() end,
    'Signature Documentation')

  -- Lesser used LSP functionality
  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  map('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })
    }),
  },
}




-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
