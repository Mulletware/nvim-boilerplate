return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  keys = {
    -- Document existing key chains
    { '<leader>w', name = '[W]orkspace' },
    { '<leader>c', name = '[C]ode' },
    { '<leader>d', name = '[D]ocument' },
    { '<leader>r', name = '[R]ename' },
    { '<leader>s', name = '[S]earch' },
  },
}
