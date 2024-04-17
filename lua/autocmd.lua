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

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    for _, arg in ipairs(vim.v.argv) do
      if vim.fn.filereadable(arg) == 1 then
        local dir = vim.fn.fnamemodify(arg, ':h')
        while dir ~= '/' do
          local gitDir = dir .. '/.git'
          if vim.fn.isdirectory(gitDir) == 1 or vim.fn.filereadable(gitDir) == 1 then
            vim.cmd('cd ' .. dir)
            return
          end
          dir = vim.fn.fnamemodify(dir, ':h')
        end
      elseif vim.fn.isdirectory(arg) == 1 then
        vim.cmd('cd ' .. arg)
        return
      end
    end
  end,
  once = true,
})

vim.api.nvim_create_autocmd('BufDelete', {
  callback = function()
    local len = require('utils.table').table_len(require('utils.tabs').get_tabs())
    print(len)
    if len < 2 then -- no tabs remaining
      vim.cmd ':Dashboard'
    end
  end,
})

require 'user.autocmd'
