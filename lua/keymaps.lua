--[[ -- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = require 'utils.map'

require 'concessions'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Custom mappings

map('n', ';', ':', { desc = 'CMD enter command mode' })

map('n', '<leader>fm', function()
  require('conform').format()
end, { desc = 'File Format with conform' })

-- map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Generic Text Editor mappings --

-- map Ctrl + s to Save
map({ 'n', 'i' }, '<C-s>', ':w<CR>', { desc = 'Save File' })

-- map Ctrl+F to telescope live_grep
map({ 'n', 'i' }, '<C-f>', '<cmd>Telescope live_grep<cr>', { desc = 'Find Text in Files (Normal Mode)' })

-- map Ctrl + w to close Buffer/tab
map('n', '<C-w>', ':bd<cr>', { desc = 'Close File' })
map('i', '<C-w>', '<cmd>bd<cr>', { desc = 'Close File' })

-- map Ctrl + q to quit (press enter to confirm, add ! to force)
map({ 'n', 'i' }, '<C-q>', '<cmd>qa<cr>', { desc = 'Close Application' })

-- Sublime Text mappings --

-- map Ctrl+D to Multi-Cursor
map('n', '<C-d>', '<Plug>(VM-Find-Under)', { noremap = true, silent = true, desc = 'Start Multi-Cursor (Normal Mode)' })
map('x', '<C-d>', '<Plug>(VM-Find-Subword-Under)', { noremap = true, silent = true, desc = 'Start Multi-Cursor (Visual Mode)' })

-- map Ctrl + ] and Ctrl + [ to indent/unindent code
map({ 'n', 'i' }, '<C-]>', '>>', 'Indent')
map({ 'n', 'i' }, '<C-[>', '<<', 'Indent Backward')
map('v', '<C-[>', '<gv', 'Indent Backward (Visual Mode)')
map('v', '<C-]>', '>gv', 'Indent (Visual Mode)')

-- Visual mode
map('v', '<C-d>', '<Plug>(VM-Find-Subword-Under)', { noremap = true, silent = true, desc = 'Start Multi-Cursor (Visual Mode)' })

-- Insert mode
map('i', '<C-d>', '<Plug>(VM-Insert-Cursor-At-EndOfEachLine)', { noremap = true, silent = true, desc = 'Start Multi-Cursor (Insert Mode)' })

-- Skip instance
map({ 'n', 'i', 'v' }, '<C-k>', '<Plug>(VM-Skip-Region)', { noremap = true, silent = true, desc = 'Skip instance (Normal Mode)' })

-- map({'n', 'i', 'v'}, '<C-S-t>', ':tabnew#', {noremap = true, silent = true, desc = "Open previously closed tab" })

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
-- map("n", "<C-S-?>", comment, { noremap = true, desc = "Comment line (Visual Mode)" })
map('i', '<C-/>', comment, { noremap = true, desc = 'Comment line (Visual Mode)' })
-- map("i", "<C-S>?", comment, { noremap = true, desc = "Comment line (Visual Mode)" })
map('v', '<C-/>', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', 'Comment line (Visual Mode)')
map('v', '<C-S>?', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', 'Comment line (Visual Mode)')

-- Map <C-S-/> or <C-S-?> to toggle block comment using Comment.nvim
-- map('v', '<C-Alt-/>', '<C-\\><C-N><Cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', {noremap = true, silent = true})
-- map('v', '<C-S-?>', '<C-\\><C-N><Cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', {noremap = true, silent = true})
map(
  'v',
  '<C-Alt-/>',
  '<Cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>',
  { noremap = true, silent = true, desc = 'Comment block (Visual Mode)' }
)

map('n', '<C-S-t>', ':lua g:reopen_last_tab()', { noremap = true, silent = true })

-- map Ctrl + o to open project
map('n', '<C-o>', ':cd ~/', { noremap = true, desc = 'Open Project' })

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

map('n', '<expr><tab>', '<C-l>', { desc = 'Tab based completion' })

-- map Ctrl+Shift+Enter to ZenMode
map({ 'n', 'i', 'v' }, '<C-S-Enter>', '<cmd>ZenMode<cr>', { desc = 'Zen Mode' })


-- map Ctrl+Shift+k to go to definition
map('n', '<C-S-k>', ': gd<cr>', { desc = 'Go to definition' })
