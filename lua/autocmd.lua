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

-- local WinNew_group = vim.api.nvim_create_augroup('WinNewVerticalSplit', { clear = true })
-- vim.api.nvim_create_autocmd("WinNew", {
--   command = 'wincmd L',
--   group = WinNew_group,
-- })

-- local BufEnterTerm_group = vim.api.nvim_create_augroup('BufEnterTermInsertMode', { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   command = 'startinsert',
--   pattern = 'term://*',
--   group = BufEnterTerm_group,
-- })
