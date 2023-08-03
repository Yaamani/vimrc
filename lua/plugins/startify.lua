-- vim.g.startify_change_to_dir = 0
vim.g.startify_session_persistence = 1
-- vim.g.startify_session_delete_buffers = 0
vim.g.startify_lists = {
  { ['type'] = 'sessions',  ['header'] = {'   Sessions'} },
  { ['type'] = 'files',     ['header'] = {'   MRU'} },
  { ['type'] = 'dir',       ['header'] = {'   MRU ' .. vim.fn.getcwd()} },
  { ['type'] = 'bookmarks', ['header'] = {'   Bookmarks'} },
  { ['type'] = 'commands',  ['header'] = {'   Commands'} },
}
