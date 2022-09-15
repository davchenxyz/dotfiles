local opt = vim.opt

local helpers = require('helpers')
local augroup = helpers.augroup
local autocmd = helpers.autocmd

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 5

-- Tabs & spaces
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Display tabs and trailing spaces as special characters
--
-- Tip: In insert mode, type 'C-v u' then hex code to insert special character.
-- Tip: When the cursor is on the character, type 'ga' to display it's code on
-- command line.
opt.list = true
opt.listchars = { tab = '»·', trail = '·', nbsp = '␣', extends = '»', precedes = '«' }

-- Minimal screen lines/columns to keep when moving cursor
-- 'scrolloff' also affects quickfix list so don't set it too high
opt.scrolloff = 5
opt.sidescrolloff = 5

-- Clipboard
opt.clipboard = 'unnamedplus'

-- Conceal
opt.concealcursor = 'nc'
opt.conceallevel = 0

-- Command line height
opt.cmdheight = 1

-- Colorscheme
opt.termguicolors = true
opt.background = 'dark'

-- Mouse scroll in terminal
opt.mouse = 'a'

-- Don't show things like '-- INSERT --' in command line
-- opt.showmode = false

-- Options with default values
-- I wrote them to remind myself, because they may be useful in future.
opt.signcolumn = 'auto'
opt.undofile = false
opt.smartindent = false

-- Global status line
opt.laststatus = 3

-- vim.cmd [[
--   augroup CursorLine
--     autocmd!
--     autocmd WinEnter,BufWinEnter * setlocal cursorline
--     autocmd WinLeave * setlocal nocursorline
--   augroup END
-- ]]

-- Highlight cursor line for current window
augroup('CursorLine', function(group)
  autocmd({'WinEnter', 'BufWinEnter'}, {
    group = group,
    pattern = '*',
    callback = function() vim.opt_local.cursorline = true end
  })

  autocmd('WinLeave', {
    group = group,
    pattern = '*',
    callback = function() vim.opt_local.cursorline = false end
  })
end)

-- Time (ms) to wait for a mapped sequence to complete
-- also affect which-key plugin
-- opt.timeoutlen = 500

-- Yank highlight
augroup('YankHighlight', function(group)
  autocmd('TextYankPost', {
    group = group,
    pattern = '*',
    callback = function() vim.highlight.on_yank({ timeout = 200 }) end
  })
end)

-- Abbriviations
-- Enter current date with format YYYY-MM-DD
vim.cmd [[
  inorea <expr> ymd strftime('%Y-%m-%d')
]]
