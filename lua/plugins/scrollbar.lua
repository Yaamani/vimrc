local vsc = require('vscode.colors').get_colors()

require("scrollbar").setup({
  show = true,
  show_in_active_only = false,
  set_highlights = true,
  folds = 1000,                    -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
  max_lines = false,               -- disables if no. of lines in buffer exceeds this
  hide_if_all_visible = false,     -- Hides everything if all lines are visible
  throttle_ms = 100,
  handle = {
    color = vsc.vscSplitDark
  },
  marks = {
    Error = { priority = 1 },
    Warn = { priority = 2 },
    Info = { priority = 3 },
    Hint = { priority = 4 },
    Search = {
      color = vsc.vscOrange,
      priority = 5
    },
  },
  handlers = {
    cursor = false
  },
})
