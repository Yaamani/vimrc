require('neoscroll').setup({
  easing_function = 'sine',
  -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', --[['<C-y>', '<C-e>',--]] 'zt', 'zz', 'zb'},
  use_local_scrolloff = true,
  respect_scrolloff = true,
  hide_cursor = false,
})
local keymap = {
  ["<C-u>"] = function() require('neoscroll').ctrl_u({ duration = 50 }) end;
  ["<C-d>"] = function() require('neoscroll').ctrl_d({ duration = 50 }) end;
  ["<C-b>"] = function() require('neoscroll').ctrl_b({ duration = 100 }) end;
  ["<C-f>"] = function() require('neoscroll').ctrl_f({ duration = 100 }) end;
  ["<C-y>"] = function() require('neoscroll').scroll(-0.2, { move_cursor=false; duration = 25 }) end;
  ["<C-e>"] = function() require('neoscroll').scroll(0.2, { move_cursor=false; duration = 25 }) end;
  ["zt"]    = function() require('neoscroll').zt({ half_win_duration = 50 }) end;
  ["zz"]    = function() require('neoscroll').zz({ half_win_duration = 50 }) end;
  ["zb"]    = function() require('neoscroll').zb({ half_win_duration = 50 }) end;
}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end
