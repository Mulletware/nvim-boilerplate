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

-- update nvim-tree syntax on load
local config_group = vim.api.nvim_create_augroup('UserConfig', {}) -- A global group for all your config autocommands
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionLoadPost',
  group = config_group,
  callback = function()
    require('nvim-tree.api').tree.toggle(false, true)
  end,
})

-- Auto save session
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      -- Don't save while there's any 'nofile' buffer open.
      if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'nofile' then
        return
      end
    end
    require('session_manager').save_current_session()
  end,
})

-- handle directory or file args
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    for _, arg in ipairs(vim.v.argv) do
      if vim.fn.filereadable(arg) == 1 then
        local dir = vim.fn.fnamemodify(arg, ':h')
        if dir ~= arg then
          return
        end

        while dir ~= '/' do
          local gitDir = dir .. '/.git'
          -- also check if a .git FILE exists for managed repos (`gitdir: ...`)
          if vim.fn.isdirectory(gitDir) == 1 or vim.fn.filereadable(gitDir) == 1 then
            vim.cmd('cd ' .. dir)
            return
          end

          dir = vim.fn.fnamemodify(dir, ':h')
        end

        vim.cmd('e ' .. arg)
      elseif vim.fn.isdirectory(arg) == 1 then
        vim.cmd('cd ' .. arg)

        require('session_manager').load_current_dir_session(true)

        vim.schedule(function() -- WE WAIT BECAUSE WE MUST
          -- without this little trick if you open a directory like `nvim ~/path/to/dir`
          --   the last files loaded in the session will be lacking highlighting
          vim.cmd ':e'
        end)
        return
      end
    end
  end,
  once = true,
})

vim.api.nvim_create_autocmd('BufDelete', {
  callback = function(args)
    local bufid = args.buf
    local tabs = require('utils.tabs').get_tabs()
    local tabCount = require('utils.table').table_len(tabs)

    if tabCount < 3 then
      for _, tab in ipairs(tabs) do
        if tab == bufid then
          print(vim.inspect(tabs))
          vim.cmd ':Dashboard'
          break
        end
      end
    end
  end,
})

require 'user.autocmd'
