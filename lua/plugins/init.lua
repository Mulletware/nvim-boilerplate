-- You can add your own plugins here or in other files in this directory!plugin
--  I promise not to create any merge conflicts in this directory :)

-- See the kickstart.nvim README for more information

return {
  {
    'Exafunction/codeium.vim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    event = 'BufEnter',
  },

  {
    'mg979/vim-visual-multi',
    branch = 'master',
    lazy = false,
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },

  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup {}
    end,
  },

  {
    'gennaro-tedesco/nvim-possession',
    dependencies = {
      'ibhagwan/fzf-lua',
    },
    config = true,
    init = function()
      local possession = require 'nvim-possession'
      vim.keymap.set('n', '<leader>sl', function()
        possession.list()
      end)
      vim.keymap.set('n', '<leader>sn', function()
        possession.new()
      end)
      vim.keymap.set('n', '<leader>su', function()
        possession.update()
      end)
      vim.keymap.set('n', '<leader>sd', function()
        possession.delete()
      end)
    end,
  },

  {
    'Shatur/neovim-session-manager',
    lazy = false,
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {}
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- 'rcarriga/nvim-notify',
    },
  },

  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup {
        icons = true,
      }
    end,
  },

  'folke/neodev.nvim',

  'folke/zen-mode.nvim',

  'folke/twilight.nvim',

  'Mohammed-Taher/AdvancedNewFile.nvim',

  'mfussenegger/nvim-lua-debugger',

  'junegunn/fzf.vim',

  'tpope/vim-fugitive',

  'jbyuki/instant.nvim',

  'Rykka/lastbuf.vim',

  'vim-scripts/Rename2',

  'nvim-pack/nvim-spectre',

  'onsails/lspkind.nvim',

  'ThePrimeagen/refactoring.nvim',

  'xiyaowong/nvim-transparent',

  'mbbill/undotree',

  'fabridamicelli/cronex.nvim',

  'smoka7/hop.nvim',
}
