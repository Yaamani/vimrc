-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- greatest remap ever (thePrimeagen)
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })

-- vim.keymap.set('n', '<leader>sf', function() return require('telescope.builtin').find_files({ search_dirs={".", ".."} }) end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[S]earch existing [b]uffers' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sF', function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true, no_ignore_parent = true }) end, { desc = 'Search files (including hidden & ignored)' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

vim.keymap.set({ 'n', 'v' }, '<Space>F', ':Neoformat<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Next diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Previous diagnostic' })
vim.keymap.set('n', '[e', function () vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Next error' })
vim.keymap.set('n', ']e', function () vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Previous error' })
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, { desc = 'diagnostic.open_float' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'diagnostic.setloclist' })




vim.keymap.set('n', jit.os ~= "OSX" and '<A-h>' or '˙', ':BufferLineCyclePrev<cr>', { noremap = true })
vim.keymap.set('n', jit.os ~= "OSX" and '<A-l>' or '¬', ':BufferLineCycleNext<cr>', { noremap = true })
vim.keymap.set('n', '<A-left>', ':BufferLineMovePrev<cr>', { noremap = true })
vim.keymap.set('n', '<A-right>', ':BufferLineMoveNext<cr>', { noremap = true })


vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, desc = ':NvimTreeToggle' })


vim.keymap.set('n', jit.os ~= "OSX" and '<A-w><A-w>' or '∑∑', ':b#<CR>:bd#<CR>:<ESC>' --[[ the :<ESC> is a little hack to refresh the bufferline ]], { desc = 'Delete a buffer' })
vim.keymap.set('n', jit.os ~= "OSX" and '<A-w><A-q>' or '∑œ', '<C-w>q', { desc = 'Quit a window' })



local function handle_term(term_map)
  if jit.os == "Windows" then
    local sh = vim.o.shell
    return [[:let &shell=executable('pwsh')?'pwsh':'powershell'<CR>]] .. term_map .. ':set shell=' .. sh .. '<CR>'
  else
    return term_map
  end
end

vim.keymap.set('n', jit.os ~= "OSX" and '<A-t>t' or '†t', handle_term(':term<CR>'))
vim.keymap.set('n', jit.os ~= "OSX" and '<A-t>j' or '†j', handle_term(':bel split +term<CR>'))
vim.keymap.set('n', jit.os ~= "OSX" and '<A-t>k' or '†k', handle_term(':split +term<CR>'))
vim.keymap.set('n', jit.os ~= "OSX" and '<A-t>l' or '†l', handle_term(':vsplit +term<CR>'))
vim.keymap.set('n', jit.os ~= "OSX" and '<A-t>h' or '†h', handle_term(':lefta vsplit +term<CR>'))

vim.keymap.set('n', jit.os ~= "OSX" and '<A-t>n' or '†n', ':tabnext<CR>')
vim.keymap.set('n', jit.os ~= "OSX" and '<A-t>p' or '†p', ':tabprevious<CR>')


-- vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true})
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true})

vim.keymap.set({ 'n', 'v', 'o' }, 'L', '$', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'H', function()
  local cursor_column_position = vim.api.nvim_win_get_cursor(0)[2]
  local index_of_first_non_space_char = string.find(vim.api.nvim_get_current_line(), "%S")
  if index_of_first_non_space_char == nil then return '0' end
  if cursor_column_position < index_of_first_non_space_char then return '0' else return '^' end
end, { noremap = true, expr = true })

vim.keymap.set('v', '//', 'y/<C-R>=substitute(escape(@", \'/\\.*$^~[\'), \'\\_s\\+\', \'\\\\_s\\\\+\', \'g\')<CR><CR>N',
  { noremap = true })
vim.keymap.set('v', '/c',
  'y/\\C<C-R>=substitute(escape(@", \'/\\.*$^~[\'), \'\\_s\\+\', \'\\\\_s\\\\+\', \'g\')<CR><CR>Ncgn', { noremap = true })

vim.keymap.set('n', '\\h', ':noh<CR>')

vim.keymap.set('n', jit.os ~= "OSX" and '<A-j>' or '∆', ':m .+1<CR>==', { noremap = true })
vim.keymap.set('n', jit.os ~= "OSX" and '<A-k>' or '˚', ':m .-2<CR>==', { noremap = true })
vim.keymap.set('v', jit.os ~= "OSX" and '<A-j>' or '∆', ':m \'>+1<CR>gv=gv', { noremap = true })
vim.keymap.set('v', jit.os ~= "OSX" and '<A-k>' or '˚', ':m \'<-2<CR>gv=gv', { noremap = true })

vim.keymap.set('n', '<C-w>m', ':WindowsMaximize<CR>')
vim.keymap.set('n', 'MM', ':WindowsMaximize<CR>')
vim.keymap.set('n', 'MH', ':WindowsMaximizeHorizontally<CR>')
vim.keymap.set('n', 'MV', ':WindowsMaximizeVertically<CR>')
vim.keymap.set('n', '<C-w>_', ':WindowsMaximizeVertically<CR>')
vim.keymap.set('n', '<C-w>|', ':WindowsMaximizeHorizontally<CR>')
vim.keymap.set('n', '<C-w>=', ':WindowsEqualize<CR>')

-- vim.keymap.set('n', 'gui', require("gitui").open, { desc = 'gitui' })
-- vim.keymap.set('n', 'gib', ':Gitsigns blame_line<CR>')
-- vim.keymap.set('n', 'giB', ':Gitsigns toggle_current_line_blame<CR>')
vim.keymap.set('n', 'gH', ':Gitsigns prev_hunk<CR>')
vim.keymap.set('n', 'gh', ':Gitsigns next_hunk<CR>')
vim.keymap.set('n', 'gph', ':Gitsigns preview_hunk<CR>')
vim.keymap.set({ 'n', 'v' }, 'gsh', ':Gitsigns stage_hunk<CR>')
vim.keymap.set({ 'n', 'v' }, 'grh', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', 'dvc', ':DiffviewClose<CR>')
vim.keymap.set('n', 'dvo', ':DiffviewOpen<CR>')
vim.keymap.set('n', 'dvh', ':DiffviewFileHistory %<CR>')
vim.keymap.set('n', 'dvH', ':DiffviewFileHistory<CR>')

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- vim.keymap.set('n', '<TAB>', 'i<TAB>', { noremap = true });
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.keymap.set('i', 'kj', '<ESC>', { noremap = true })
-- vim.keymap.set('n', '<CR>', 'a<CR><ESC>', { noremap = true });

-- DAP keymaps
vim.keymap.set('n', 'dui', require('dapui').toggle, { desc = 'DAP: Dapui toggle' })
vim.keymap.set('n', '<F12>', function() require('dap').continue() end, { desc = 'DAP: Continue' })
vim.keymap.set('n', '<F10>', function() require('dap').disconnect() end, { desc = 'DAP: Disconnect' })
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end, { desc = 'DAP: Step over' })
vim.keymap.set('n', '<F9>', function() require('dap').step_into() end, { desc = 'DAP: Step into' })
vim.keymap.set('n', '<F7>', function() require('dap').step_out() end, { desc = 'DAP: Step out' })
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'DAP: Toggle breakpoint' })
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint(vim.fn.input("Braakpoint condition: ")) end, { desc = 'DAP: Set conditional breakpoint' })
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'DAP: Log point message' })
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = 'DAP: REPL open' })
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = 'DAP: Re-run the last debug adapter' })
vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'DAP: ui.widgets.hover' })
vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end, { desc = 'DAP: ui.widgets.preview' })
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = 'DAP: ui.widgets.centered_float(widgets.frames)' })
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = 'DAP: ui.widgets.centered_float(widgets.scopes)' })


vim.keymap.set('t', 'jk', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', 'kj', '<C-\\><C-n>', { noremap = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set('t', '<C-u>', '<C-\\><C-n>:lua require("neoscroll").scroll(-vim.wo.scroll, true, 50)<CR>', { noremap = true })

local function moveBracket(c)
  local cursor_column_position = vim.api.nvim_win_get_cursor(0)[2]
  local char_under_cursor = vim.api.nvim_get_current_line():sub(cursor_column_position+1, cursor_column_position+1)
  if char_under_cursor == '(' or char_under_cursor == ')' then if c == ']' then return '])' else return '[(' end end
  if char_under_cursor == '<' or char_under_cursor == '>' then if c == ']' then return ']>' else return '[<' end end
  if c == ']' then return ']}' else return '[{' end
end

vim.keymap.set({ 'n', 'v' }, jit.os ~= "OSX" and '<A-[>' or '“', function () return moveBracket('[') end, { expr = true })
vim.keymap.set({ 'n', 'v' }, jit.os ~= "OSX" and '<A-]>' or '‘', function () return moveBracket(']') end, { expr = true })
vim.keymap.set({ 'n', 'v' }, jit.os ~= "OSX" and '<A-b>' or '∫', '%')


vim.keymap.set('n', '<leader>x', ':so<CR>')


vim.keymap.set('i', jit.os ~= "OSX" and '<A-j>' or  '∆' , function() return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', jit.os ~= "OSX" and '<A-l>' or  '¬' , function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
vim.keymap.set('i', jit.os ~= "OSX" and '<A-h>' or  '˙' , function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
vim.keymap.set('i', jit.os ~= "OSX" and '<A-x>' or  '≈' , function() return vim.fn['codeium#Clear']() end, { expr = true })


-- vim.keymap.set('n', '<leader>pe', "<cmd>lua require('swenv.api').pick_venv()<cr>", { desc = "Pick python virtualenv" });


-- vim.keymap.set('n', 'gf', function ()
--   local cursor_row_position = vim.api.nvim_win_get_cursor(0)[1]
--   local cursor_column_position = vim.api.nvim_win_get_cursor(0)[2]
--   local window_height = vim.api.nvim_win_get_height(0)
--   local visible_lines = vim.api.nvim_buf_get_lines(0, cursor_row_position - window_height, cursor_row_position + window_height, false)
--   -- local paths = string.match(table.concat(visible_lines), '([%w_%-]+/)+%.[%w_%-]+')
--   -- local paths = string.match(table.concat(visible_lines), '([%w_%-]+/)*')
--   vim.regex('((?:[^/]*/)*)(.*)')
--   print(vim.inspect(paths))
-- end)

-- vim.loop.os_uname()
