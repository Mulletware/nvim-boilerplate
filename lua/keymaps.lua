--[[ -- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = require 'utils.map'

require 'concessions'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
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

map({ 'n', 'v', 'i' }, '<C-c>', '"+', { desc = 'Activate system clipboard', silent = true, noremap = true })

-- Buffer Navigation
-- <Leader>1-9 will jump to that tab
for i = 1, 9 do
  map('n', '<Leader>' .. i, function()
    require('utils.buffers').switch_to_tab(i)
  end, { desc = 'Go to buffer ' .. i })
end

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', ':winc h<cr>', { desc = 'Move focus to the left pane', silent = true })
map('n', '<C-l>', ':winc l<cr>', { desc = 'Move focus to the right pane', silent = true })
map('n', '<C-j>', ':winc j<cr>', { desc = 'Move focus to the lower pane', silent = true })
map('n', '<C-k>', ':winc k<cr>', { desc = 'Move focus to the upper pane', silent = true })

-- Window tiling
map({ 'n', 'i' }, '<C-A-o>', ':only<cr>', { desc = 'Pane becomes the only one', silent = true })
map({ 'n', 'i' }, '<C-A-w>', ':close<cr>', { desc = 'Pane Close', silent = true })

map({ 'n', 'i' }, '<C-A-h>', ':vnew<cr>', { desc = 'Pane open to the right', silent = true })
map({ 'n', 'i' }, '<C-A-l>', ':vsplit<cr>', { desc = 'Pane open to the right (current file)', silent = true })
map({ 'n', 'i' }, '<C-A-j>', ':new<cr>', { desc = 'Pane open below', silent = true })
map({ 'n', 'i' }, '<C-A-k>', ':split<cr>', { desc = 'Pane open below', silent = true })

-- Window tile resizing
map({ 'n', 'i' }, '<C-S-A-h>', ':vertical resize -2<cr>', { desc = 'Resize vertical pane down', silent = true })
map({ 'n', 'i' }, '<C-S-A-j>', ':resize -2<cr>', { desc = 'Resize horizontal pane down', silent = true })
map({ 'n', 'i' }, '<C-S-A-k>', ':resize +2<cr>', { desc = 'Resize horizontal pane up', silent = true })
map({ 'n', 'i' }, '<C-S-A-l>', ':vertical resize +2<cr>', { desc = 'Resize vertical pane up', silent = true })

local closeTab = function()
  require('mini.bufremove').unshow()
end

-- map('n', '<Leader>w', closeTab, { desc = 'Close window', silent = true })
-- map('n', '<Leader>q', ':close<cr>', { desc = 'Close window', silent = true })

-- Custom mappings

map('n', '<C-CR>', ':', { desc = 'CMD enter command mode' })

-- Generic Text Editor mappings --

-- map Ctrl + s to Save
map({ 'n', 'i' }, '<C-s>', ':w<CR>', { desc = 'Save File', silent = true, noremap = true })
map('n', '<Leader>s', ':w<CR>', { desc = 'Save File', silent = true })

-- map Ctrl+F to telescope live_grep
map({ 'n', 'i' }, '<C-f>', '<cmd>Telescope live_grep<cr>', { desc = 'Find Text in Files (Normal Mode)' })

-- map Ctrl + w to close Buffer/tab
-- map({ 'i', 'n' }, '<C-w>', closeTab, { desc = 'Close File', silent = true })
-- map({ 'i', 'n' }, '<C-S-w>', ':bd!<cr>', { desc = 'Close File (forced)', silent = true })
map({ 'i', 'n', 'v' }, '<C-A-q>', closeTab, { desc = 'Pane Close', silent = true })
map({ 'i', 'n', 'v' }, '<C-q>', ':bd<cr>', { desc = 'Close File', silent = true })
map({ 'i', 'n', 'v' }, '<C-q><C-q>', ':bd!<cr>', { desc = 'Close File', silent = true })
map({ 'i', 'n', 'v' }, '<C-q><C-q><C-q>', ':q<cr>', { desc = 'Close File', silent = true })
map({ 'i', 'n', 'v' }, '<C-q><C-q><C-q><C-q>', ':q!<cr>', { desc = 'Close File', silent = true })
map({ 'i', 'n', 'v' }, '<C-q><C-q><C-q><C-q>', ':q!<cr>', { desc = 'Close File', silent = true })

-- map Ctrl + t to new buffer
map({ 'n', 'i' }, '<C-t>', '<cmd>enew<cr>', { desc = 'New Buffer', silent = true })

-- map Ctrl + q to quit (press enter to confirm, add ! to force)
-- map({ 'n', 'i' }, '<leader>q', '<cmd>qa', { desc = 'Close Application', silent = true })
-- map({ 'n', 'i' }, '<C-S-q>', '<cmd>qa<cr>', { desc = 'Close Application', silent = true })
-- map({ 'n', 'i' }, '<C-A-S-q>', '<cmd>qa!<cr>', { desc = 'Close Application without saving', silent = true })

-- map Ctrl + ] and Ctrl + [ to indent/unindent code
map({ 'n', 'i' }, '<C-]>', '>>', { desc = 'Indent', silent = true })
map({ 'n', 'i' }, '<C-[>', '<<', { desc = 'Indent Backward', silent = true })
map('v', '<C-[>', '<gv', { desc = 'Indent Backward (Visual Mode)', silent = true })
map('v', '<C-]>', '>gv', { desc = 'Indent (Visual Mode)', silent = true })

-- map Ctrl+Shift+t to reopen last closed tab with LastBuf
map({ 'n', 'i' }, '<C-S-t>', ':LastBuf', { desc = 'Reopen last closed tab', silent = true })

-- map Ctrl + b to Neotree open
map({ 'n', 'i' }, '<C-b>', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle Neotree (Normal Mode)' })

-- map Ctrl+P to telescope find Files
map({ 'n', 'i', 'v' }, '<C-P>', '<cmd>Telescope find_files<cr>', { desc = 'Find Files (Normal Mode)', noremap = true })
-- map("i", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Normal Mode)" })

-- Ctrl+Shift+P to toggle command menu (":")
map({ 'n', 'i' }, '<C-S-p>', ':Telescope buffers<cr>', { desc = 'Fuzzy Find In Open Buffers', silent = true })

-- map Ctrl+A to select all
map({ 'n', 'i' }, '<C-a>', '<cmd>normal ggVG<cr>', { desc = 'Select all (Normal Mode)', silent = true })

-- map Ctrl + / to comment line

local comment = function()
  require('Comment.api').toggle.linewise.current()
end

map('n', '<C-/>', comment, { noremap = true, desc = 'Comment line (Normal mode)', silent = true })
map('i', '<C-/>', comment, { noremap = true, desc = 'Comment line (Visual Mode)', silent = true })
map('v', '<C-/>', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>gv=gv', { desc = 'Comment line (Visual Mode)', silent = true })

map('v', '<C-A-/>', '<C-\\><C-N><Cmd>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', { noremap = true, silent = true })

map('v', '<C-S>?', function()
  require('Comment.api').toggle.blockwise(vim.fn.visualmode())
  vim.cmd 'normal! gv=gv'
end, { desc = 'Comment line (Visual Mode)', silent = true })

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
map('n', '<Leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit', silent = true })
--
-- map Space + ld to LazyDocker
map('n', '<Leader>ld', '<cmd>LazyDocker<cr>', { desc = 'LazyDocker', silent = true })

-- map Space + gd to Gitsigns diffthis
map('n', '<Leader>gd', '<cmd>Gitsigns diffthis<cr>', { desc = 'Git Diff (Normal Mode)' })
map('n', '<Leader>gg', '<cmd>Neogit<cr>', { desc = 'Neogit' })

-- map <Tab> to next tab
map('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Switch to next tab' })
map('n', '<S-tab>', '<cmd>bprevious<cr>', { desc = 'Switch to next tab' })

map('n', '<leader>l', '<cmd>bnext<cr>', { desc = 'Switch to next tab' })
map('n', '<leader>h', '<cmd>bprevious<cr>', { desc = 'Switch to previous tab' })

-- map Ctrl+Shift+Enter to ZenMode
map({ 'n', 'i', 'v' }, '<C-S-Enter>', '<cmd>ZenMode<cr>', { desc = 'Zen Mode' })

-- Undo/Redo
map({ 'n', 'i', 'v' }, '<C-z>', 'u', { desc = 'Undo' })
map({ 'n', 'i', 'v' }, '<C-y>', '<C-r>', { desc = 'Redo' })
map({ 'n', 'i', 'v' }, '<C-S-z>', '<C-r>', { desc = 'Redo' })

-- Tabs
map({ 'n', 'i', 'v' }, '<C-S-t>', '<C-o>', { desc = 'Open last closed buffer' })

-- Minimap
map({ 'n', 'v' }, '<Leader>m', ":lua require('mini.map').toggle()<cr>", { desc = 'Toggle Minimap', silent = true })

-- Move lines up and down
map({ 'n', 'i' }, '<C-S-j>', ':m +1<cr>', { desc = 'Move line down', silent = true })
map({ 'n', 'i' }, '<C-S-k>', ':m -2<cr>', { desc = 'Move line up', silent = true })
map('v', '<C-S-j>', ":m '>+1<cr>gv=gv", { desc = 'Move line down', silent = true })
map('v', '<C-S-k>', ":m '<-2<cr>gv=gv", { desc = 'Move line up', silent = true })

-- Map <leader>rw to replace all instances of current word
map('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { noremap = true, desc = 'Replace all instances of current word' })

-- Undo Tree
map({ 'i', 'n' }, '<C-S-u>', '<cmd>UndotreeToggle<cr>', { desc = 'Toggle Undo Tree' })
map({ 'n', 'i', 'v' }, '<C-A-S-U>', '<cmd>UndotreeToggle<cr>', { desc = 'Toggle Undo Tree', silent = true })

-- -- YankBank
-- map({ 'n', 'v' }, '<leader>y', '<cmd>YankBank<cr>', { desc = 'Open YankBank', silent = true })

-- BufSurf

map({ 'n', 'i', 'v' }, '<A-l>', '<cmd>BufSurfForward<cr>', { noremap = true, silent = true })
map({ 'n', 'i', 'v' }, '<A-h>', '<cmd>BufSurfBack<cr>', { noremap = true, silent = true })
map({ 'n', 'i', 'v' }, '<A-ScrollWheelDown>', '<cmd>BufSurfForward<cr>', { noremap = true, silent = true })
map({ 'n', 'i', 'v' }, '<A-ScrollWheelUp>', '<cmd>BufSurfBack<cr>', { noremap = true, silent = true })
map({ 'n', 'i', 'v' }, '<X1Mouse>', '<cmd>BufSurfBack<cr>', { noremap = true, silent = true })
map({ 'n', 'i', 'v' }, '<X2Mouse>', '<cmd>BufSurfForward<cr>', { noremap = true, silent = true })

-- Tabs

map({ 'n', 'v' }, '<leader>n', ':enew<cr>', { desc = 'Blank new file', silent = true, noremap = true })
map({ 'n', 'v' }, '<leader>tt', ':tab split<cr>', { desc = 'New Tab', silent = true, noremap = true })
map({ 'n', 'v' }, '<leader>tc', ':tabclose<cr>', { desc = 'New Tab', silent = true, noremap = true })
map({ 'n', 'v' }, '<leader>tl', ':tabNext<cr>', { desc = 'Next tab', silent = true, noremap = true })
map({ 'n', 'v' }, '<leader>th', ':tabprevious<cr>', { desc = 'Previous tab', silent = true, noremap = true })
map({ 'n', 'v' }, '<leader><Tab>', ':tabNext<cr>', { desc = 'Next tab', silent = true, noremap = true })
map({ 'n', 'v' }, '<leader><S-Tab>', ':tabprevious<cr>', { desc = 'Previous tab', silent = true, noremap = true })

-- Rest
map({ 'n', 'v' }, '<leader>rr', ':Rest run<cr>', { desc = 'Rest Run', silent = true, noremap = true })

-- Escape.nvim
map({ 'n', 'v' }, '<leader>e', ':lua require("escape").escape', { noremap = true, silent = true })

-- DapInfo
map('n', '<Leader>br', '<cmd>DapInfoRevealBp<cr>', { desc = 'Dap Info Show Breakpoint Info', silent = true })
map('n', '<Leader>bn', '<cmd>DapInfoNextBp<cr>', { desc = 'Dap Info Next Breakpoint', silent = true })
map('n', '<Leader>bp', '<cmd>DapInfoPrevBp<cr>', { desc = 'Dap Info Previous Breakpoint', silent = true })
map('n', '<Leader>bu', '<cmd>DapInfoUpdateBp<cr>', { desc = 'Dap Info Update Breakpoint', silent = true })

require 'user.keymaps'
