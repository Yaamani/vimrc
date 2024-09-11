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

--------------------------------------------------------------------------------
-- performance related autocmd
-- performance related autocmd
-- performance related autocmd
local large_files_disable_group = vim.api.nvim_create_augroup('LargeFilesDisable', { clear = true })
-- disable some features and plugins before loading file, this time the buffer is loaded but file is still not loaded
vim.api.nvim_create_autocmd("BufReadPre", {
  group = large_files_disable_group,
  pattern = "*",
  callback = function()
    vim.opt.spell = false
    require("illuminate").pause_buf()
  end,
})
-- after file is loaded, determine whether to enable the disabled features/plugins
vim.api.nvim_create_autocmd("BufReadPost", {
  group = large_files_disable_group,
  pattern = "*",
  callback = function()
    local max_filesize = 500 * 1204 -- 500 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
    if ok and stats and stats.size < max_filesize then
      vim.opt.spell = true
      require("illuminate").resume_buf()
    end
  end,
})
--------------------------------------------------------------------------------
-- augroup set_jenkins_groovy
-- au!
-- au BufNewFile,BufRead *.jenkinsfile,*.Jenkinsfile,Jenkinsfile,jenkinsfile setf groovy
-- augroup END
local jenkinsfile_groovy_file_group = vim.api.nvim_create_augroup('SetJenkinsfileGroovy', { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = jenkinsfile_groovy_file_group,
  pattern = { '*.jenkinsfile', '*.Jenkinsfile', 'Jenkinsfile', 'jenkinsfile' },
  command = 'setf groovy',
})
--------------------------------------------------------------------------------

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
