return {
  'jonathan-elize/dap-info.nvim',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    require('dap-info').setup {}
  end,
}
