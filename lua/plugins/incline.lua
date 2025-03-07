return {
  'b0o/incline.nvim',
  config = function()
    require('incline').setup(vim.g.incline_config)
  end,
  event = 'VeryLazy',
}
