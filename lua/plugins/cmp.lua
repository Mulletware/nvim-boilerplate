return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      build = 'make install_jsregexp',
      -- (function()
      --   -- Build Step is needed for regex support in snippets.
      --   -- This step is not supported in many windows environments.
      --   -- Remove the below condition to re-enable on windows.
      --   if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      --     return
      --   end
      --   return 'make install_jsregexp'
      -- end)(),
      config = function()
        require('luasnip.loaders.from_snipmate').lazy_load()
      end,
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'abecodes/tabout.nvim',
    'tamago324/cmp-zsh',
    'SergioRibera/cmp-dotenv',
  },
  config = function()
    -- -- See `:help cmp`
    -- local cmp = require 'cmp'
    -- local luasnip = require 'luasnip'
    -- luasnip.config.setup {}
    --
    -- cmp.setup {
    --   snippet = {
    --     expand = function(args)
    --       luasnip.lsp_expand(args.body)
    --     end,
    --   },
    --   completion = { completeopt = 'menu,menuone,noinsert' },
    --
    --   -- For an understanding of why these mappings were
    --   -- chosen, you will need to read `:help ins-completion`
    --   --
    --   -- No, but seriously. Please read `:help ins-completion`, it is really good!
    --   mapping = cmp.mapping.preset.insert {
    --     -- Select the [n]ext item
    --     ['<C-n>'] = cmp.mapping.select_next_item(),
    --     -- Select the [p]revious item
    --     ['<C-p>'] = cmp.mapping.select_prev_item(),
    --
    --     -- Scroll the documentation window [b]ack / [f]orward
    --     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --
    --     -- Accept ([y]es) the completion.
    --     --  This will auto-import if your LSP supports it.
    --     --  This will expand snippets if the LSP sent a snippet.
    --     ['<C-y>'] = cmp.mapping.confirm { select = true },
    --
    --     -- Manually trigger a completion from nvim-cmp.
    --     --  Generally you don't need this, because nvim-cmp will display
    --     --  completions whenever it has completion options available.
    --     ['<C-Space>'] = cmp.mapping.complete {},
    --
    --     -- Think of <c-l> as moving to the right of your snippet expansion.
    --     --  So if you have a snippet that's like:
    --     --  function $name($args)
    --     --    $body
    --     --  end
    --     --
    --     -- <c-l> will move you to the right of each of the expansion locations.
    --     -- <c-h> is similar, except moving you backwards.
    --     ['<C-l>'] = cmp.mapping(function()
    --       if luasnip.expand_or_locally_jumpable() then
    --         luasnip.expand_or_jump()
    --       end
    --     end, { 'i', 's' }),
    --     ['<C-h>'] = cmp.mapping(function()
    --       if luasnip.locally_jumpable(-1) then
    --         luasnip.jump(-1)
    --       end
    --     end, { 'i', 's' }),
    --
    --     -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --     --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps

    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    local accept = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }
      else
        fallback()
      end
    end

    local next = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end

    local previous = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<CR>'] = cmp.mapping(accept),
        ['<C-l>'] = cmp.mapping(accept),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          elseif require('utils.text').has_words_before() then
            accept(fallback)
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif vim.api.nvim_get_mode().mode == 'i' then
            fallback()
          end
        end, { 'i', 's' }),

        ['<C-j>'] = cmp.mapping(next, { 'i', 's' }),
        ['<ScrollWheelDown>'] = cmp.mapping(next, { 'i', 's' }),

        ['<C-k>'] = cmp.mapping(previous, { 'i', 's' }),
        ['<ScrollWheelUp'] = cmp.mapping(previous, { 'i', 's' }),

        ['<Esc>'] = cmp.mapping(function(fallback)
          local tookAction = false

          if cmp.visible() then
            cmp.abort()
            tookAction = true
          end

          if luasnip.expand_or_jumpable() then
            luasnip.unlink_current()
          end

          if not tookAction then
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'zsh' },
        { name = 'codeium' },
        { name = 'dotenv' },
      },
    }
    cmp.setup.filetype({ 'sql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })
  end,
}
