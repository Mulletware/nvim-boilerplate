return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  lazy = false,
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      hide = {
        statusline = false,
        tabline = false,
      },
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Keymaps',
            group = 'DiagnosticHint',
            action = 'Telescope keymaps',
            key = 'm',
          },
          {
            desc = ' Browse',
            group = 'Number',
            action = 'NvimTreeToggle',
            key = 'b',
          },
          {
            desc = ' Files',
            group = 'Number',
            action = 'Telescope oldfiles',
            key = 'o',
          },
          {
            desc = '? Help',
            group = 'Help',
            action = 'Telescope help_tags',
            key = 'h',
          },
        },
      },
    }
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
