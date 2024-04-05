return {
  'mistricky/codesnap.nvim',
  build = 'make',
  config = function()
    require('codesnap').setup {
      watermark = '',
      mac_window_bar = false,
      has_breadcrumbs = true,
    }
  end,
}
