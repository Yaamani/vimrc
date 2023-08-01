require('windows').setup({
  autowidth = { enable = false },
  -- autowidth = {
  --   enable = true,
  --   winwidth = 5,
  --   filetype = {
  --     help = 2,
  --   },
  -- },
  ignore = {
    buftype = { "quickfix" },
    filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
  },
  animation = {
    -- enable = true,
    enable = false,
    duration = 150,
    fps = 60,
    easing = "in_out_sine"
  },
})
