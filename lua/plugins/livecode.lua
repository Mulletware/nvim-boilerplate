return {
  'jxm35/livecode.nvim',
  config = function()
    require('livecode').setup { username = vim.g.livecode_username }
  end,
}
