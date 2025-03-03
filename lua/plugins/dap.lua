-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local map = require 'utils.map'

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- -- Basic debugging keymaps, feel free to change to your liking!
    -- vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    -- vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    -- vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    -- vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    -- vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    -- vim.keymap.set('n', '<leader>B', function()
    --   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    -- end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()

    dap.set_log_level 'TRACE'

    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '-i', 'dap' },
    }

    dap.adapters.chrome = {
      type = 'executable',
      command = 'node',
      args = { vim.g.dap_home .. 'vscode-chrome-debug/out/src/chromeDebug.js' },
    }

    dap.adapters.firefox = {
      type = 'executable',
      command = 'node',
      args = { vim.g.dap_home .. 'vscode-firefox-debug/dist/adapter.bundle.js' },
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
        -- webRoot = '${workspaceFolder}',
      },
      {
        name = 'Node',
        type = 'launch',
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
      {
        name = 'Attach to Firefox (javascript) [unsupported]',
        type = 'firefox',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9223,
        -- webRoot = '${workspaceFolder}',
      },
    }

    dap.configurations.typescript = dap.configurations.javascript[1]
    dap.configurations.typescriptreact = dap.configurations.javascript[1]
    dap.configurations.javascriptreact = dap.configurations.javascript[1]

    dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = {
        vim.fn.stdpath 'data' .. '/dapinstall/jsnode_dbg/' .. '/vscode-node-debug2/out/src/nodeDebug.js',
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
      args = { vim.g.dap_home .. 'vscode-php-debug/out/phpDebug.js' },
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        pathMappings = {
          ['/var/www/html/src'] = vim.fn.getcwd() .. '/src',
        },
        port = 9003,
      },
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

    map('n', '<Leader>bc', function()
      require('dap').continue()
    end, { desc = 'Breakpoint Continue' })
    map('n', '<Leader>bs', function()
      require('dap').step_over()
    end, { desc = 'Breakpoint Step Over' })
    map('n', '<Leader>bi', function()
      require('dap').step_into()
    end, { desc = 'Breakpoint Step Into' })
    map('n', '<Leader>bo', function()
      require('dap').step_out()
    end, { desc = 'Breakpoint Step Out' })
    map('n', '<Leader>bb', function()
      require('dap').toggle_breakpoint()
    end, { desc = 'Breakpoint Toggle' })
  end,
}
