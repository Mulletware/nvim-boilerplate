return {
  'Mulletware/lazydocker.nvim',
  event = 'VeryLazy',
  opts = {}, -- automatically calls `require("lazydocker").setup()`
  config = function()
    require('lazydocker').setup {
      popup_window = {
        position = '0%',
        relative = 'editor',
        size = {
          width = '100%',
          height = '100%',
        },
      },
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
