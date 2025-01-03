return {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        filetypes = { 'css', 'html', 'javascript', 'lua' }, -- Add filetypes as needed
        user_default_options = {
          RGB = true, -- #RGB format
          RRGGBB = true, -- #RRGGBB format
          names = true, -- 'Red', 'Blue' names
          RRGGBBAA = true, -- #RRGGBBAA format
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
        },
      }
    end,
  },
}
