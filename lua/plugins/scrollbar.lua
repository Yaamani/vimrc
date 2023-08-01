local vsc = require('vscode.colors').get_colors()

require("scrollbar").setup({
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
