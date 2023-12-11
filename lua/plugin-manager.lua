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
      { 'j-hui/fidget.nvim', tag = "legacy", opts = {} },

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
  'rafamadriz/friendly-snippets',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',          opts = {} },

  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      -- require("scrollbar.handlers.gitsigns").setup()
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
    priority = 1000,
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
    -- commit = 'db9ee339b5556aa832ca58871fd18f9467a18520'
  },
  {
    'folke/tokyonight.nvim'
  },



   -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',

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

  -- [[ DAP (Debug Adapter Protocol) ]]
  'mfussenegger/nvim-dap',
  'jay-babu/mason-nvim-dap.nvim',
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim',
  -- {
  --   'microsoft/vscode-js-debug',
  --   lazy = true,
  --   build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out'
  -- },
  -- 'mxsdev/nvim-dap-vscode-js',



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

  -- {
  --   'prettier/vim-prettier',
  --   build = 'yarn install --frozen-lockfile --production',
  -- },

  'sbdchd/neoformat',

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
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  { 'karb94/neoscroll.nvim' },

  -- {
  --   'petertriho/nvim-scrollbar',
  --   config = function()
  --   end
  -- },

  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require('hlslens').setup()
      -- require("scrollbar.handlers.search").setup({
      --   -- hlslens config overrides
      -- })
    end,
  },

  'mhinz/vim-startify',

  'RRethy/vim-illuminate',

  'jiangmiao/auto-pairs',

  'ray-x/lsp_signature.nvim',

  'JoosepAlviste/nvim-ts-context-commentstring',

  { 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },

  'christoomey/vim-tmux-navigator',

  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      -- vim.o.equalalways = false
    end
  },

  'aspeddro/gitui.nvim',

  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

  'uga-rosa/ccc.nvim', -- color picker/colorizer

  -- { 'chaoren/vim-wordmotion', },

  'mbbill/undotree',

  'tpope/vim-abolish',

  'nvim-treesitter/playground',

  {
    'kkoomen/vim-doge',
    build = ':call doge#install()'
  },

  'Exafunction/codeium.vim',

  -- 'AckslD/swenv.nvim',

  'mfussenegger/nvim-dap-python',

}, {})
