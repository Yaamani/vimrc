require("mason-nvim-dap").setup({
  ensure_installed = { "js-debug-adapter" }
})

require('dap-python').setup('~/.virtualenvs/debugpy/Scripts/python.exe')

require("nvim-dap-virtual-text").setup()

require("dapui").setup()

local dap, dapui = require "dap", require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#ff0000', --[[ bg = '#31353f' ]] })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', --[[ bg = '#31353f' ]] })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', --[[ bg = '#31353f' ]] })

vim.fn.sign_define('DapBreakpoint',           { text='', texthl='DapBreakpoint', --[[linehl='DapBreakpoint', numhl='DapBreakpoint']] })
vim.fn.sign_define('DapBreakpointCondition',  { text='ﳁ', texthl='DapBreakpoint', --[[linehl='DapBreakpoint', numhl='DapBreakpoint']] })
vim.fn.sign_define('DapBreakpointRejected',   { text='', texthl='DapBreakpoint', --[[linehl='DapBreakpoint', numhl='DapBreakpoint']] })
vim.fn.sign_define('DapLogPoint',             { text='', texthl='DapLogPoint',   --[[linehl='DapLogPoint',   numhl='DapLogPoint']] })
vim.fn.sign_define('DapStopped',              { text='', texthl='DapStopped',    --[[linehl='DapStopped',    numhl='DapStopped']] })


require("dap").adapters["coreclr"] = {
  type = 'executable',
  command = vim.fn.expand('~') .. '\\netcoredbg\\netcoredbg.exe',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

-- require("dap-vscode-js").setup({
--   -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
--   debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter", -- Path to vscode-js-debug installation.
--   debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
--   adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
--   log_file_path = vim.fn.stdpath("cache") .. "/dap_vscode_js.log", -- Path for file logging
--   -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
--   log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
-- })

require('dap').defaults.javascript.exception_breakpoints = {'caught', 'uncaught'}
require('dap').defaults.typescript.exception_breakpoints = {'caught', 'uncaught'}
require('dap').defaults["pwa-node"].exception_breakpoints = {'caught', 'uncaught'}

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

require("dap").configurations["typescript"] = {
  {
    name = 'Launch default',
    type = 'pwa-node',
    request = 'launch',
    runtimeExecutable = '${workspaceFolder}/node_modules/.bin/ts-node', -- Path to a ts-node executable (VIP)
    program = '${file}',
    cwd = '${workspaceFolder}',
    skipFiles = { '<node_internals>/**' },
    console = 'integratedTerminal',
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require 'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Debug Jest Tests",
    -- trace = true, -- include debugger info
    runtimeExecutable = "node",
    runtimeArgs = {
      "./node_modules/jest/bin/jest.js",
      "--runInBand",
    },
    -- rootPath = "${workspaceFolder}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
  },
}

require("dap").configurations["javascript"] = {
  {
    name = 'Launch reddit',
    type = 'pwa-node',
    request = 'launch',
    program = '${file}',
    -- rootPath = '${workspaceFolder}',
    cwd = '${workspaceFolder}',
    skipFiles = { '<node_internals>/**' },
    console = 'integratedTerminal',
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require 'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  }
}
