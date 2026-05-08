-- mini.bufremove ships with mini.nvim (already installed in init.lua)
require('mini.bufremove').setup {}
vim.keymap.set('n', '<leader>C', function() require('mini.bufremove').delete(0, true) end, { desc = 'Close Buffer' })
