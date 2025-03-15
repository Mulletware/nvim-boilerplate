vim.g.set_scroll = function(lines)
  vim.cmd('execute "set scroll=' .. lines .. '"')
end

vim.cmd [[autocmd FileType markdown set tw=80|set wrap]]

require 'user.autocmd'
