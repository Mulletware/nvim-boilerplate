return {
  -- 'salkin-mada/openscad.nvim',
  'dabstractor/openscad.nvim',
  config = function()
    require 'openscad'
    -- load snippets, note requires
    vim.g.openscad_load_snippets = true

    local ft = require 'Comment.ft'
    ft.set('openscad', ft.get 'clang' or { '// %s', '/* %s */' })
  end,
  dependencies = { 'L3MON4D3/LuaSnip' },
}
