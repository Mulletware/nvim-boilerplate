-- Neovide is a lightweight Neovim GUI written in Rust.
-- Using a GUI instead of a terminal allows for more complete keymapping

local map = require 'utils.map'

if vim.g.neovide then
  map('n', '<F11>', ':let g:neovide_fullscreen = !g:neovide_fullscreen<CR>', { desc = 'Toggle Fullscreen', silent = true })

  local scaling_factor = 1.03
  local reverse_scaling_factor = 1 / scaling_factor

  -- map Ctrl+=/- to increase and decrease font size
  map('n', '<C-=>', ':let g:neovide_scale_factor = g:neovide_scale_factor * ' .. scaling_factor .. '<CR>', { desc = 'Zoom in', silent = true })
  map('n', '<C-->', ':let g:neovide_scale_factor = g:neovide_scale_factor * ' .. reverse_scaling_factor .. '<CR>', { desc = 'Zoom out', silent = true })

  -- since we're in neovide we can leverage the full Ctrl+f and Ctrl+Shift+f search functionality normally intercepted by the shell
  map({ 'n', 'i' }, '<C-S-f>', '<cmd>Telescope live_grep<cr>', { desc = 'Find Text in Files (Normal Mode)' })
  map({ 'n', 'i' }, '<C-f>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Find Text in Files (Normal Mode)' })

  map({ 'n', 'i' }, '<C-tab>', '<cmd>bnext<cr>', 'Next Buffer/tab')
  map({ 'n', 'i' }, '<C-S-tab>', '<cmd>bprevious<cr>', 'Next Buffer/tab')

  vim.schedule(function()
    vim.cmd 'NeovideFocus'
  end)
end
