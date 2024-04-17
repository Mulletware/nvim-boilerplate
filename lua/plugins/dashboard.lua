return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      hide = {
        statusline = false,
        tabline = false,
      },
    }
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
