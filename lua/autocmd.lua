local set_scroll = function(divisor)
  vim.cmd('execute "set scroll=' .. math.floor(vim.api.nvim_win_get_height(0) / divisor) .. '"')
end

vim.g.set_scroll = function(divisor)
  set_scroll(divisor)

  vim.api.nvim_create_autocmd({ 'BufEnter', 'VimResized', 'BufNew', 'WinScrolled' }, {
    desc = 'Set scroll height on window enter',
    group = vim.api.nvim_create_augroup('scroll-height-enter', { clear = true }),
    callback = function()
      set_scroll(divisor)
    end,
  })
end

require 'user.autocmd'
