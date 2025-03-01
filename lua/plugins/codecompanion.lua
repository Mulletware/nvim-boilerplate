return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function(_, opts)
    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'githubmodels',
          keymaps = {
            close = {
              modes = { n = "<leader>ccw", i = "<C-c><C-w>" },
            },
          }
        },
        inline = {
          adapter = 'githubmodels',
        },
        cmd = {
          adapter = 'githubmodels',
        },
      },
      -- adapters = {
      --   githubmodels = function()
      --     return require('codecompanion.adapters').extend('githubmodels', {
      --       schema = {
      --         model = {
      --           default = 'DeepSeek-R1',
      --         },
      --       },
      --     })
      --   end,
      -- },
    }
  end,
}
