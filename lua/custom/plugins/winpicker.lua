vim.pack.add {
  'https://github.com/yorickpeterse/nvim-window',
}

local winpicker = require 'nvim-window'

vim.keymap.set('n', '<leader>wj', function() winpicker.pick() end, { noremap = true })
