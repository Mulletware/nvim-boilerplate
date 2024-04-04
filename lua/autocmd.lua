-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- automatically convert javascript files to react
vim.api.nvim_create_augroup('filetype_jsx', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript',
  callback = function()
    vim.bo.filetype = 'javascriptreact'
  end,
  group = 'filetype_jsx',
})

vim.api.nvim_create_user_command('Snippets', function()
  require('luasnip.loaders').edit_snippet_files()
end, { nargs = '*' })

require 'user.autocmd'
