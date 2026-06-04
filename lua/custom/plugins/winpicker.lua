vim.pack.add {
  'https://github.com/yorickpeterse/nvim-window',
}

local winpicker = require 'nvim-window'

vim.keymap.set({ 'n', 't', 'i' }, '<M-a>', function() winpicker.pick() end, { noremap = true })
