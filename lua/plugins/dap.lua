-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
--
return {
  '/mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '-i', 'dap' },
    }

    dap.adapters.chrome = {
      type = 'executable',
      command = 'node',
      args = { os.getenv 'HOME' .. '~/src/vscode-chrome-debug/out/src/chromeDebug.js' }, -- TODO adjust
    }

    dap.configurations.javascript = {
      {
        name = 'Attach to Chrome (javascript)',
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
      {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require('dap.utils').pick_process,
      },
    }

    dap.configurations.typescriptreact = { -- change to typescript if needed
      {
        name = 'Attach to Chrome (react)',
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }

    dap.adapters.firefox = {
      type = 'executable',
      command = 'node',
      args = { os.getenv 'HOME' .. '/path/to/vscode-firefox-debug/dist/adapter.bundle.js' },
    }

    dap.configurations.typescript = {
      {
        name = 'Debug with Firefox',
        type = 'firefox',
        request = 'launch',
        reAttach = true,
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
        firefoxExecutable = '/usr/bin/firefox',
      },
    }

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- 💀 Make sure to update this path to point to your installation
        --     args = {"/path/to/js-debug/src/dapDebugServer.js", "${port}"},
      },
    }

    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#PHP
    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { '~/src/vscode-php-debug/out/phpDebug.js' },
    }

    dap.adapters.neovim = function(callback)
      local server = require('lua_debugger').launch()
      callback { type = 'server', host = server.host, port = server.port }
    end

    dap.configurations.lua = {
      type = 'neovim',
      request = 'attach',
      name = 'Attach to running neovim instance',
    }
  end,
}
