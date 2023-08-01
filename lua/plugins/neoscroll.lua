require('neoscroll').setup({
  -- easing_function = 'sine',
  -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', --[['<C-y>', '<C-e>',--]] 'zt', 'zz', 'zb'},
  use_local_scrolloff = true,
  respect_scrolloff = true,
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
