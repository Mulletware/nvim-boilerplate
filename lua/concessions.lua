-- This file is for all the things that just had to happen because of quirks in vim.
-- For example, vim automatically interpresets <C-[> as <Esc> and vice-versa. This means you cannot bind
-- anything to <C-[> without that macro being run every time you press <Esc> to exit insert mode.
-- Some necessary plumbing needs to be done to have an experience similar to the one found in modern
-- editors and originally spearheaded by Sublime Text

local map = require 'utils/map'

-- Detach vim's ancient equivalence between <Esc> and <C-[>
map('i', '<Esc>', '<Esc>', {noremap = true})
map('n', '<Esc>', '<Esc>', {noremap = true})
map('v', '<Esc>', '<Esc>', {noremap = true})
map('c', '<Esc>', '<Esc>', {noremap = true})
map('i', '<C-[>', '<<', {noremap = true})
map('n', '<C-[>', '<<', {noremap = true})
map('v', '<C-[>', '<<', {noremap = true})
map('c', '<C-[>', '<<', {noremap = true})
