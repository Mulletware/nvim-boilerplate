return {
  'jose-elias-alvarez/buftabline.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('buftabline').setup {}
  end,
}
