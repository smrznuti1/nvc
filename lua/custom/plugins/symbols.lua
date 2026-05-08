vim.pack.add { 'https://github.com/oskarrrrrrr/symbols.nvim' }
local r = require 'symbols.recipes'
require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, {})
vim.keymap.set('n', ',s', '<cmd>SymbolsToggle<CR>')
