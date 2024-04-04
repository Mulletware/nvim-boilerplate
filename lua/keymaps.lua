--[[ -- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = require 'utils.map'

require 'concessions'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<C-c>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Tab Navigation
-- <Leader>1-9 will jump to that tab
for i = 1, 9 do
  map('n', '<Leader>' .. i, function()
    require('utils.tabs').switch_to_tab(i)
  end, { desc = 'Go to tab ' .. i })
end

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Custom mappings

map('n', ';', ':', { desc = 'CMD enter command mode' })

-- Generic Text Editor mappings --

-- map Ctrl + s to Save
map({ 'n', 'i' }, '<C-s>', ':w<CR>', { desc = 'Save File' })

-- map Ctrl+F to telescope live_grep
map({ 'n', 'i' }, '<C-f>', '<cmd>Telescope live_grep<cr>', { desc = 'Find Text in Files (Normal Mode)' })

-- map Ctrl + w to close Buffer/tab
map('n', '<C-w>', ':bd<cr>', { desc = 'Close File' })
map('i', '<C-w>', '<cmd>bd<cr>', { desc = 'Close File' })

-- map Ctrl + t to new buffer
map({ 'n', 'i' }, '<C-t>', '<cmd>enew<cr>', { desc = 'New Buffer' })

-- map Ctrl + q to quit (press enter to confirm, add ! to force)
map({ 'n', 'i' }, '<C-q>', '<cmd>qa<cr>', { desc = 'Close Application' })
map({ 'n', 'i' }, '<C-S-q>', '<cmd>qa!<cr>', { desc = 'Close Application without saving' })

-- Sublime Text mappings --

-- map Ctrl + ] and Ctrl + [ to indent/unindent code
map({ 'n', 'i' }, '<C-]>', '>>', 'Indent')
map({ 'n', 'i' }, '<C-[>', '<<', 'Indent Backward')
map('v', '<C-[>', '<gv', 'Indent Backward (Visual Mode)')
map('v', '<C-]>', '>gv', 'Indent (Visual Mode)')

-- Skip instance
map({ 'n', 'i', 'v' }, '<C-k>', '<Plug>(VM-Skip-Region)', { noremap = true, silent = true, desc = 'Skip instance (Normal Mode)' })

-- map Ctrl+Shift+t to reopen last closed tab with LastBuf
map({ 'n', 'i' }, '<C-S-t>', ':LastBuf', { desc = 'Reopen last closed tab' })

-- map Ctrl + b to Neotree open
map({ 'n', 'i' }, '<C-b>', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle Neotree (Normal Mode)' })

-- map Ctrl+P to telescope find Files
map({ 'n', 'i' }, '<C-p>', '<cmd>Telescope find_files<cr>', { desc = 'Find Files (Normal Mode)' })
-- map("i", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Normal Mode)" })

-- Ctrl+Shift+P to toggle command menu (":")
map({ 'n', 'i' }, '<C-S-P>', ':', { desc = 'Command Menu Toggle (Normal Mode)' })

-- map Ctrl+A to select all
map({ 'n', 'i' }, '<C-a>', '<cmd>normal ggVG<cr>', { desc = 'Select all (Normal Mode)' })

-- map Ctrl + / to comment line

local comment = function()
  require('Comment.api').toggle.linewise.current()
end

map('n', '<C-/>', comment, { noremap = true, desc = 'Comment line (Normal mode)' })
map('i', '<C-/>', comment, { noremap = true, desc = 'Comment line (Visual Mode)' })
map('v', '<C-/>', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>gv=gv', 'Comment line (Visual Mode)')

map('v', '<C-A-/>', '<C-\\><C-N><Cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

map('v', '<C-S>?', function()
  require('Comment.api').toggle.blockwise(vim.fn.visualmode())
  vim.cmd 'normal! gv=gv'
end, 'Comment line (Visual Mode)')

map(
  'v',
  '<C-Alt-/>',
  '<Cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>',
  { noremap = true, silent = true, desc = 'Comment block (Visual Mode)' }
)

-- map Ctrl + o to open project
map('n', '<Leader>oo', ':cd ~/', { noremap = true, desc = 'Open Project' })

-- map Ctrl + Shift + o to open file
map('n', '<Leader>of', ':e ', { noremap = true, desc = 'Open File' })

-- map ~ to open project
map('n', '~', ':cd ~/', { noremap = true, desc = 'Open Home Directory' })

-- map ! to run shell command
map('n', '!', ':! ', { noremap = true, desc = 'Run shell command' })

-- map Ctrl+! to run shell command with output to buffer
map('n', '<C-1>', ':r! ', { noremap = true, desc = 'Run shell command output to buffer' })

-- map Space + lg to LazyGit
map('n', '<Leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- map Space + gd to Gitsigns diffthis
map('n', '<Leader>gd', '<cmd>Gitsigns diffthis<cr>', { desc = 'Git Diff (Normal Mode)' })

-- map <Tab> to next tab
map('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Switch to next tab' })
map('n', '<S-tab>', '<cmd>bprevious<cr>', { desc = 'Switch to next tab' })

-- map('n', '<expr><tab>', '<C-l>', { desc = 'Tab based completion' })

-- map Ctrl+Shift+Enter to ZenMode
map({ 'n', 'i', 'v' }, '<C-S-Enter>', '<cmd>ZenMode<cr>', { desc = 'Zen Mode' })

-- map Ctrl+Shift+K to add cursor above
map({ 'n', 'i', 'v' }, '<C-S-K>', '<Plug>(VM-Add-Cursor-Up)', { desc = 'Add cursor above' })

-- map Ctrl+Shift+J to add cursor below
map({ 'n', 'i', 'v' }, '<C-S-J>', '<Plug>(VM-Add-Cursor-Below)', { desc = 'Add cursor below' })

-- harpoon keymappings

map('n', '<Leader>ad', function()
  require('harpoon'):list():append()
end, { desc = 'Harpoon Add' })

-- Undo/Redo
map({ 'n', 'i', 'v' }, '<C-z>', 'u', { desc = 'Undo' })
map({ 'n', 'i', 'v' }, '<C-y>', '<C-r>', { desc = 'Redo' })
map({ 'n', 'i', 'v' }, '<C-S-z>', '<C-r>', { desc = 'Redo' })

-- Tabs
map({ 'n', 'i', 'v' }, '<C-S-t>', '<C-o>', { desc = 'Open last closed buffer' })

-- Minimap
map({ 'n', 'i', 'v' }, '<C-m>', MiniMap.toggle, { desc = 'Toggle Minimap' })

-- Move lines up and down
map({ 'n', 'i' }, '<C-S-j>', ':m +1<cr>', { desc = 'Move line down' })
map({ 'n', 'i' }, '<C-S-k>', ':m -2<cr>', { desc = 'Move line up' })
map('v', '<C-S-j>', ":m '>+1<cr>gv=gv", { desc = 'Move line down' })
map('v', '<C-S-k>', ":m '<-2<cr>gv=gv", { desc = 'Move line up' })

-- Map <leader>rw to replace all instances of current word
map('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { noremap = true, silent = true, desc = 'Replace all instances of current word' })

require 'user.keymaps'
