return {
  'crnvl96/lazydocker.nvim',
  event = 'VeryLazy',
  opts = {
    popup_window = {
      position = '0%',
      relative = 'editor',
      size = {
        width = '100%',
        height = '100%',
      },
    },
  }, -- automatically calls `require("lazydocker").setup()`
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
