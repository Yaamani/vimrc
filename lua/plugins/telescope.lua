-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    winblend = 25,
    layout_strategy = "vertical",
    -- path_display = { shorten = 1 },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--multiline",
      -- "--pcre2",
      "--engine=auto",
    },
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

require('telescope').load_extension('dap')
