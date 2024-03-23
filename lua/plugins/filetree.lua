-- local on_attach_tree = function(bufnr)
--   local api = require 'nvim-tree.api'
--
--   local function opts(desc)
--     return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--   end
--
--   api.config.mappings.default_on_attach(bufnr)
--   -- vim.keymap.del({'n', 'i', 'v'}, '<C-n>', { buffer = bufnr })
--   -- vim.keymap.set('n', '<C-b>', api.tree.toggle, opts 'Toggle Explorer')
--   -- vim.keymap.set('n', '<C-b>', api.tree.toggle, opts 'Toggle Explorer')
--   vim.keymap.set('n', '<C-b>', "<cmd>NvimTreeToggle<CR>", opts 'Toggle Explorer')
-- end

local function on_attach_tree(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
  vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
end

return {
  'nvim-tree/nvim-tree.lua',
  opts = {
    on_attach = on_attach_tree,
    filters = {
      dotfiles = false,
    },

    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },

    view = {
      adaptive_size = false,
      side = 'left',
      width = 30,
      preserve_window_proportions = true,
    },

    git = {
      enable = true,
      ignore = true,
    },

    filesystem_watchers = {
      enable = true,
    },

    actions = {
      open_file = {
        resize_window = true,
      },
    },

    renderer = {
      root_folder_label = false,
      highlight_git = true,
      highlight_opened_files = 'none',

      indent_markers = {
        enable = true,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        glyphs = {
          default = '󰈚',
          symlink = '',
          folder = {
            default = '',
            empty = '',
            empty_open = '',
            open = '',
            symlink = '',
            symlink_open = '',
            arrow_open = '',
            arrow_closed = '',
          },

          git = {
            unstaged = '✗',
            staged = '✓',
            unmerged = '',
            renamed = '➜',
            untracked = '★',
            deleted = '',
            ignored = '◌',
          },
        },
      },
    },
  },
  -- config = function()
  --   require('nvim-tree').setup {
  --     on_attach = on_attach_tree,
  --   }
  -- end,

  -- 'nvim-neo-tree/neo-tree.nvim',
  -- version = '*',
  -- dependencies = {
  --   'nvim-lua/plenary.nvim',
  --   'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --   'MunifTanjim/nui.nvim',
  -- },
  -- config = function()
  --   require('neo-tree').setup {}
  -- end,
}
