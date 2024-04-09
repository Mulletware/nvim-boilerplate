local map = require 'utils.map'
local command = vim.api.nvim_create_user_command

-- Create the "Settings" command
command('Settings', function()
  -- Save the current directory
  local current_dir = vim.fn.getcwd()

  -- Get the value of $XDG_CONFIG_HOME
  local xdg_config_home = os.getenv 'XDG_CONFIG_HOME'

  -- If $XDG_CONFIG_HOME is not set, use the default value
  if xdg_config_home == nil then
    xdg_config_home = os.getenv 'HOME' .. '/.config'
  end

  -- Construct the path to the Neovim configuration directory
  local nvim_config_dir = xdg_config_home .. '/nvim'

  -- Open a new terminal buffer
  vim.cmd 'terminal'

  -- Get the current buffer number
  local buf = vim.api.nvim_get_current_buf()

  -- Send the `cd` command to the terminal buffer
  vim.api.nvim_chan_send(buf, 'cd ' .. nvim_config_dir .. '\n')

  -- Send the command to open the init.lua file in the terminal buffer
  vim.api.nvim_chan_send(buf, 'nvim init.lua\n')

  -- Create an autocommand to restore the directory when the terminal buffer is closed
  vim.cmd('autocmd TermClose <buffer> lcd ' .. current_dir)
end, {})

-- command('Snippets', function()
--   -- open user snippets directory at $XDG_CONFIG_HOME/nvim/snippets/
-- end, {})

-- Create the VMAddCursorsToVisualSelection function in the global scope
function Add_cursors_to_visual_selection(start_line, end_line)
  -- Move the cursor to the start line of the selection
  vim.fn.cursor { start_line, 1 }

  -- Add cursors to each line of the selection
  for _ = start_line, end_line - 1 do
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(VM-Add-Cursor-Down)', true, false, true), 'n')
  end
end

-- Make the function accessible to the command
vim.api.nvim_set_var('Add_cursors_to_visual_selection', Add_cursors_to_visual_selection)

-- Create a custom command that accepts a range
vim.api.nvim_exec(
  [[
    command! -range VMAddCursorsToVisualSelection lua vim.api.nvim_get_var("Add_cursors_to_visual_selection")(tonumber(vim.fn.line("'<")), tonumber(vim.fn.line("'>")))
    ]],
  false
)

-- Map the custom command to a key combination
map('v', '<C-S-l>', ':VMAddCursorsToVisualSelection<CR>', { noremap = true, desc = 'Add cursor per line selected' })

command('Git', 'LazyGit', {})

command('DeleteCurrentFile', function()
  vim.cmd ':!rip % || rm %'
  vim.cmd ':bd!'
end, {})

command('Request', function()
  require('telescope').extensions.rest.select_env()
end, { desc = 'Make an HTTP request' })

command('FormattingDisable', function()
  vim.g.disable_formatting = true
end, {
  desc = 'Disable formatting',
})
command('FormattingEnable', function()
  vim.g.disable_formatting = false
end, {
  desc = 'Enable formatting',
})
command('FormattingToggle', function()
  vim.g.disable_formatting = not vim.g.disable_formatting
end, {
  desc = 'Toggle formatting',
})

command('CopyFilePath', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
end, { desc = 'Copy file path' })

command('CopyRelativeFilePath', function()
  vim.fn.setreg('+', vim.fn.fnamemodify(vim.fn.expand '%', ':.'))
end, { desc = 'Copy file path' })

require 'user.commands'
