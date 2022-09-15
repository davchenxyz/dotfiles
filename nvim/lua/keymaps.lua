--[[
# maps

## Key name convension

Key names should align with Help doc. For example, write <Esc> instead of <esc>.
It's more clear, and you can't prevent using capital letters for key maps.

## Modes

  normal_mode = 'n',
  insert_mode = 'i',
  visual_mode = 'v',
  visual_block_mode = 'x',
  term_mode = 't',
  command_mode = 'c',

--]]

local map = vim.keymap.set

-- Global and local leader keys
map('', '<Space>', '<Nop>')

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Open init.lua in a new tab
map('n', '<Leader>fed', ':tabnew ~/.config/nvim/init.lua<CR>')

-- Better window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- better terminal navigation
map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')

map('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>')
map('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>')
map('n', '<Leader>fg', '<Cmd>Telescope live_grep<CR>')

-- Copy current buffer path to '+' register
-- Useful when running test external
map('n', '<Leader>cp', function()
  vim.cmd([[let @+ = expand('%')]])
  print('Current file path copied!')
end, { silent = true })

-- Cancel highlight search
map('n', '<Leader>sc', ':nohlsearch<CR>')

-- In insert mode
-- Move foward/backward one character
map('i', '<C-f>', '<C-o>a')
map('i', '<C-b>', '<C-o>h')

-- Save file
map('n', '<Leader>w', ':w<CR>')
map('n', '<LocalLeader>w', ':w<CR>')
