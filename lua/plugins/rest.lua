return {
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    dependencies = { 'luarocks.nvim' },
    config = function()
      vim.g.rest_nvim = {}

      require('telescope').load_extension 'rest'

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('rest_nvim', { clear = true }),
        pattern = 'http',
        callback = function()
          local lines = require('rest-nvim.dotenv').find_env_files()

          if #lines > 0 then
            vim.defer_fn(function()
              require('telescope').extensions.rest.select_env()
            end, 0)
          end
        end,
      })
    end,
  },
}
