local vsc = require('vscode.colors').get_colors()
require('vscode').setup({
  -- transparent = true,
  group_overrides = {
    -- this supports the same val table as vim.api.nvim_set_hl
    -- use colors from this colorscheme by requiring vscode.colors!
    ['@constant.builtin'] = { fg = vsc.vscBlue, bg = vsc.vscNone },
    ['@variable.builtin'] = { fg = vsc.vscBlue, bg = vsc.vscNone },
    -- ['Type'] = { fg = vsc.vscBlueGreen, bg = vsc.vscNone },
    -- ['Typedef'] = { fg = vsc.vscBlueGreen, bg = vsc.vscNone },
    -- ['@type'] = { fg = vsc.vscBlueGreen, bg = vsc.vscNone },
    -- ['@type.builtin'] = { fg = vsc.vscBlueGreen, bg = vsc.vscNone },
    -- ['@type.qualifier'] = { fg = vsc.vscBlueGreen, bg = vsc.vscNone },
    ['DiagnosticUnnecessary'] = { fg = '#888888'--[[ vsc.vscGray ]], bg = vsc.vscNone, undercurl=true },
  }
})
require('vscode').load()

-- vim.api.nvim_set_hl(0, 'DiagnosticUnneccessary', { fg = vsc.vscGray, bg = vsc.vscNone })
