require("nvim-tree").setup({
  on_attach = function (bufnr)
    require('nvim-tree.api').config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', '<C-j>', require('nvim-tree.api').node.open.edit, { desc = 'Open',  buffer = bufnr, noremap = true, silent = true, nowait = true })
  end,
  view = {
    preserve_window_proportions = true,
  },
  git = {
    enable = true,
    ignore = false,
  }
})

