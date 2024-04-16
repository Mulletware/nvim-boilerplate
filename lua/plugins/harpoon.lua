local map = vim.keymap.set

return {
  'dabstractor/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {}

    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    for i = 1, 9 do
      local cb = function()
        harpoon:list():select(i)
      end

      map('n', '<Leader>d' .. i, cb, { desc = 'Harpoon ' .. i })
      map('n', '<Leader>h' .. i, cb, { desc = 'Harpoon ' .. i })
    end

    map('n', '<Leader>ha', ':lua require("harpoon"):list():add()<cr>', { desc = 'Harpoon Add File', silent = true })

    local open_menu = function()
      toggle_telescope(harpoon:list())
    end
    local open_opts = { desc = 'Open harpoon list' }

    map('n', '<Leader>h', open_menu, open_opts)
    map('n', '<Leader>hh', open_menu, open_opts)
  end,
}
