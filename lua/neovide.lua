-- Neovide is a lightweight Neovim GUI written in Rust.
-- Using a GUI instead of a terminal allows for more complete keymapping

local map = require 'utils.map'

if vim.g.neovide then
  map('v', '<C-c>', '"+y') -- Copy
  map('n', '<C-S-v>', '"+P') -- Paste normal mode
  map('i', '<C-S-v>', '"+P') -- Paste normal mode
  map('v', '<C-S-v>', '"+P') -- Paste visual mode
  map('c', '<C-S-v>', '<C-R>+') -- Paste command mode
  map('i', '<C-S-v>', '<C-R>+') -- Paste insert mode

  vim.g.neovide_fullscreen = true
  map('n', '<F11>', ':let g:neovide_fullscreen = !g:neovide_fullscreen<CR>', {})

  -- run vimscript command to make window fullscreen by default
  -- map Ctrl + = and - to increase and decrease font size
  local scaling_factor = 1.03
  local reverse_scaling_factor = 1 / scaling_factor

  map('n', '<C-=>', ':let g:neovide_scale_factor = g:neovide_scale_factor * ' .. scaling_factor .. '<CR>', {})
  map('n', '<C-->', ':let g:neovide_scale_factor = g:neovide_scale_factor * ' .. reverse_scaling_factor .. '<CR>', {})

  -- since we're in neovide we can leverage the full Ctrl+f and Ctrl+Shift+f search functionality normally intercepted by the shell
  map({ 'n', 'i' }, '<C-S-f>', '<cmd>Telescope live_grep<cr>', { desc = 'Find Text in Files (Normal Mode)' })
  map({ 'n', 'i' }, '<C-f>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Find Text in Files (Normal Mode)' })

  map({ 'n', 'i' }, '<C-tab>', '<cmd>bnext<cr>', 'Next Buffer/tab')
  map({ 'n', 'i' }, '<C-S-tab>', '<cmd>bprevious<cr>', 'Next Buffer/tab')
end
